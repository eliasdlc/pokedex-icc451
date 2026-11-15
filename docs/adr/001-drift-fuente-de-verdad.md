# ADR-001: Drift sobre SQLite como fuente de verdad local

* Estado: aceptada
* Fecha: 2026-11-15
* Decisores: Elías De La Cruz Jiménez

## Contexto

El enunciado exige persistencia local estructurada como fuente de verdad
observable: la interfaz observa la base, la respuesta remota solo actualiza la
base, y deben funcionar offline consultas que nunca se hicieron con red
(buscar por nombre, filtrar por tipo, generación o habilidad, ordenar por
estadísticas). También exige escrituras transaccionales, índices documentados,
datos del usuario en el mismo modelo y un registro de última sincronización.
Una caché de respuestas HTTP o la caché normalizada del cliente GraphQL no
cumple: guarda respuestas, no entidades consultables.

## Decisión

Usar Drift 2.35 sobre SQLite (abierto con `drift_flutter`, que corre SQLite en
un isolate de fondo) como única fuente de verdad. 17 tablas en
`lib/core/database/tables.dart`: 11 de datos de la API, 5 del usuario y
`sync_meta`. Modo WAL. Las pantallas leen con `watch()`; el cliente GraphQL se
usa con `FetchPolicy.noCache`.

## Alternativas consideradas

* Hive: almacén clave-valor muy rápido, pero sin consultas relacionales ni
  joins; filtrar "tipo Fuego de la generación 3 ordenado por ataque" obliga a
  cargar todo en memoria y filtrar en Dart. Sin transacciones entre cajas.
* Isar: base de objetos con índices y consultas, pero su mantenimiento
  original se detuvo y depende de bifurcaciones de la comunidad; riesgo para un
  proyecto que hay que defender y mantener hasta diciembre.
* sqflite: SQLite directo, sin tipos generados ni consultas reactivas; habría
  que escribir a mano el mapeo de filas y la notificación de cambios a la UI.
* Caché de graphql_flutter (`HiveStore` o `GraphQLCache`): es una caché
  normalizada de respuestas. No permite consultas nuevas offline, no tiene
  vigencia por recurso ni transacciones, y el enunciado dice explícitamente que
  no sustituye la persistencia.

## Consideraciones

* Rendimiento: las búsquedas, filtros y orden corren en SQL con índices
  (`idx_pokemon_name`, `idx_pokemon_generation`, `idx_pokemon_total`,
  `idx_pokemon_species`, `idx_pokemon_types_type`,
  `idx_pokemon_abilities_ability`, `idx_pokemon_moves_version`,
  `idx_evolutions_chain`).
* Reactividad: Drift sabe qué tablas lee cada consulta (`readsFrom`) y la
  vuelve a emitir cuando una escritura las toca. Así se cumple "la UI observa la
  base".
* Integridad: `db.transaction` agrupa cada lote; una interrupción no deja datos
  parciales.
* Pruebas: `AppDatabase(NativeDatabase.memory())` permite probar el motor sin
  dispositivo.

## Consecuencias

* Positivas: consultas offline arbitrarias, cambios reflejados sin recargar,
  favoritos y demás datos del usuario en el mismo modelo, prueba de duplicados
  con SQL.
* Negativas: generación de código (`build_runner`) y archivo `.g.dart` que hay
  que regenerar al tocar `tables.dart`; un esquema que versionar
  (hoy `schemaVersion = 3`, con su `onUpgrade` en `MigrationStrategy`).
* Una edición hecha fuera de Drift (por ejemplo `sqlite3` por `adb`) no notifica
  a las pantallas; se cubre con el vigilante de integridad (ADR-003).
