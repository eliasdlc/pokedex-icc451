# Pokédex offline first

Proyecto final de ICC-451 Desarrollo de Aplicaciones Móviles, PUCMM, profesor
Freddy Peña.

| Integrante | Matrícula | Responsabilidad principal |
|---|---|---|
| Elías De La Cruz Jiménez | 1015-5971 | Todo el proyecto (único integrante) |

## 1. Descripción del proyecto

Pokédex para Android construida con Flutter, GraphQL (PokéAPI v1beta2) y una base
SQLite local (Drift) que es la fuente de verdad de la interfaz. La app funciona
igual con o sin Internet: la red solo actualiza la base; las pantallas nunca
consumen una respuesta remota directamente. Incluye catálogo con búsqueda,
filtros y orden, ficha completa con formas y movimientos por versión, carta
coleccionable para compartir, favoritos y ajustes de tema, idioma y movimiento
reducido, todo disponible sin conexión con los datos guardados.

## 2. Requisitos de ejecución

* Flutter 3.47 (canal stable) con Dart 3.13. Probado con Flutter 3.47.9 y Dart 3.13.7.
* Android SDK con un dispositivo o emulador Android (`minSdk` y `targetSdk` los
  define Flutter: `flutter.minSdkVersion`, `flutter.targetSdkVersion`).
* JDK 17 (el proyecto Android compila con Java 17).
* Internet en la primera ejecución. Después, la app funciona sin conexión.

## 3. Instalación

```bash
git clone git@github.com:eliasdlc/pokedex-icc451.git pokedex
cd pokedex
flutter pub get
# Los archivos generados (app_database.g.dart y lib/l10n/gen) están en el
# repositorio. Si cambias tables.dart, regenera:
dart run build_runner build --delete-conflicting-outputs
flutter run
```

Variantes útiles:

```bash
# Arrancar con la API "caída" desde el primer segundo (prueba PA-08)
flutter run --dart-define=SIMULATE_API_DOWN=true

# Medir rendimiento (compilación AOT, como en producción)
flutter run --profile

# APK de entrega
flutter build apk --release
```

Identificador de la app: `edu.pucmm.icc451.pokedex`.

Pruebas y calidad:

```bash
flutter analyze                                    # No issues found!
flutter test                                       # 70 pruebas: dominio, datos, ficha y demo del avance
flutter test --tags live --run-skipped test/live   # 7 pruebas contra PokéAPI real
```

Las pruebas de `test/live` usan la red y por eso están marcadas con la etiqueta
`live` y se saltan por defecto (`dart_test.yaml`).

## 5. Arquitectura

Tres capas por funcionalidad (`lib/features/<funcionalidad>/presentation`,
`domain` y `data`). Todas las dependencias apuntan al dominio; el dominio no
importa Flutter, Drift ni GraphQL.

* Presentación: widgets y providers. Observa streams del repositorio; nunca toca
  el cliente GraphQL ni la base.
* Dominio: `PokemonSummary`, `PokemonDetail` (con `movesFor` para filtrar
  movimientos por versión, método y orden), `CatalogQuery`, los contratos
  `PokedexRepository`, `SyncService` y `DebugConsole`, y reglas puras
  (`ToggleFavorite`, `computeMatchups`).
* Datos: `PokedexRepositoryImpl` (solo lee y escribe la base),
  `SyncEngine` (única pieza que habla con la red), fuentes local y remota, DTO
  y mapeadores, y `DriftDebugConsole`. Toda excepción de infraestructura se
  traduce a un `Failure` del dominio.
* Ninguna pantalla importa la capa de datos ni la base: hasta el Laboratorio de
  Ajustes pasa por contratos del dominio.

Las decisiones de diseño están en `docs/adr/`: ADR-001 (Drift como fuente de
verdad) y ADR-003 (delta por ids y huella).

## 9. Estrategia de sincronización

Unidireccional (PokéAPI a la base local), en segundo plano, en
`lib/features/pokedex/data/sync/sync_engine.dart`.

* Disparadores: el servicio pasa a `online` (arranque, vuelta de la red, fin de
  la caída simulada), deslizar para actualizar en el catálogo, botón
  "Reintentar ahora" de la hoja de conexión, "Sincronizar ahora" del
  Laboratorio, y el vigilante de integridad cuando hay registros alterados.
* Delta por conjunto de ids: ids remotos menos ids locales = lo que falta.
  Recupera también una fila borrada a mano.
* Huella por recurso: `sync_meta` guarda un sha1 por `pokemon:<id>` y
  `detail:<id>`. Si la huella remota coincide con la guardada, la fila existe y
  su estado es `ok`, no se reescribe.
* Vigencia (TTL): 7 días. Lo vencido se revalida por lotes comparando huellas.
* Prevención de duplicados: upsert por clave primaria dentro de transacciones;
  repetir la sincronización no crea filas nuevas.
* Concurrencia: un trabajo por llave (`refresh`, `detail:<id>`, `sprites`); una
  segunda petición igual reutiliza el `Future` en curso.
* Resiliencia: timeout de 12 s por consulta y 5 s para la sonda; hasta 4
  intentos con backoff exponencial (esperas de 0.5, 1 y 2 s, con jitter de más o
  menos 20 %; el doble si la API responde 429). Solo se reintentan fallos
  transitorios (sin red, servicio no disponible, 429). Cada reintento se
  registra en consola: `sync: reintento N tras <motivo>`, y la rendición,
  `sync: se rinde tras los reintentos: <motivo>`. Con red y sin API, un
  pedido manual (Sincronizar ahora, deslizar para actualizar, Reintentar)
  igual intenta con backoff; uno automático espera a que vuelva el servicio.
* Respuestas parciales: si GraphQL devuelve datos y errores, se aceptan los
  datos y la validación de los DTO descarta los registros incompletos.
* Interrupción: cada lote se escribe en una transacción; si la app muere a
  mitad, SQLite deshace ese lote. Las imágenes se escriben a un `.part` y se
  renombran.
* Restauración de datos alterados (OF-19 a OF-21): la huella de cada fila se
  recalcula en otro isolate (`Isolate.run`) y se compara con la guardada al
  iniciar la app, al recuperar la conectividad, al abrir la ficha (solo ese
  Pokémon), cada 20 s, al volver a primer plano y con "Verificar integridad
  ahora" del Laboratorio. Una fila borrada se detecta porque `sync_meta` la da
  por sincronizada y ya no está. Una edición desde la consola SQL del
  Laboratorio vuelve a contar los 20 s desde cero, para que el dato alterado se
  vea antes de restaurarse (PA-16). Lo
  alterado se marca `stale`; con servicio se corrige desde la API, que siempre
  prevalece; sin servicio la ficha muestra un aviso y se corrige al reconectar.
  Solo toca datos del catálogo: los favoritos no tienen equivalente remoto y no
  se sobrescriben.
* Registro de última sincronización: `sync_meta` con `resource = 'catalog'`;
  el indicador lo muestra como "hace N min". El total remoto de la última
  sincronización se guarda en `app_settings` (`catalog_remote_total`), así que
  tras un reinicio sin conexión el catálogo parcial se sigue indicando.

## 14. Código de terceros y uso de IA

Declaración que pide el §17.6 del enunciado.

* Inteligencia artificial: partes del código, de las pruebas y de esta
  documentación (README y ADR) se generaron con Claude Code (Anthropic) a
  partir de mis instrucciones. Revisé cada cambio, lo ejecuté con
  `flutter analyze`, `flutter test` y en el emulador, y respondo por todo el
  código del repositorio.
* Datos e imágenes: PokéAPI (GraphQL v1beta2) y su repositorio de sprites en
  GitHub. Se descargan en tiempo de ejecución; no están en el repositorio.
* Paquetes: las dependencias de `pubspec.yaml` (Riverpod, Drift, graphql,
  connectivity_plus, http, share_plus, audioplayers y las demás), cada una bajo
  su licencia.
* Fuentes: Poppins, Tiny5, Roboto Mono y Noto Sans JP, bajo la SIL Open Font
  License (`assets/fonts/OFL-*.txt`).
* Íconos de la barra y fondo de batalla (`assets/icons`, `assets/battle`):
  ORIGEN POR CONFIRMAR.
