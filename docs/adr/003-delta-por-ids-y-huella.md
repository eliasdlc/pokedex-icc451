# ADR-003: Delta por conjunto de ids y huella sha1 por recurso con TTL

* Estado: aceptada
* Fecha: 2026-11-15
* Decisores: Elías De La Cruz Jiménez

## Contexto

PokéAPI GraphQL (Hasura) no expone fecha de modificación por registro, ni
ETag, ni un cursor de cambios. Aun así hay que: no descargar todo en cada
arranque, no duplicar registros al repetir la sincronización, recuperar lo que
falte tras una interrupción, aplicar cambios remotos y, por OF-19, detectar
un dato del catálogo alterado en la base local y restaurarlo con la versión de
PokéAPI, que prevalece siempre.

## Decisión

1. Delta del catálogo por conjunto: pedir la lista de ids remotos
   (`CatalogIds`, 1025 ids, unos 12 KB sin comprimir), restar los ids locales y
   pedir solo los faltantes en lotes de 100 con `id: {_in: [...]}`.
2. Huella por recurso: `sync_meta` guarda un sha1 (sobre una lista canónica en
   JSON) por `pokemon:<id>` y `detail:<id>`. Si la huella remota coincide con la
   guardada, la fila existe y su estado es `ok`, solo se renueva la fecha.
3. Vigencia: TTL de 7 días. Lo vencido, lo marcado `stale` y lo que quedó en
   `error` se revalida por lotes.
4. Vigilante de integridad (OF-20): al iniciar la app, al recuperar la
   conectividad, cada 20 s, al volver a primer plano y con "Verificar integridad
   ahora" del Laboratorio se recalcula la huella de cada fila local en otro
   isolate; al abrir una ficha, solo la de ese Pokémon. Si no coincide con la
   guardada, alguien la editó; si `sync_meta` la da por sincronizada y la fila
   no está, alguien la borró. En ambos casos se marca `stale` y, con servicio,
   se corrige. Solo toca datos del catálogo (OF-21).
5. Una edición desde la consola SQL del Laboratorio no se verifica en el acto:
   vuelve a contar los 20 s desde cero. Así el dato alterado se ve en catálogo y
   ficha antes de que el vigilante lo restaure, que es lo que pide PA-16.

## Alternativas consideradas

* Paginación por offset (`limit`/`offset`): descarga todo cada vez o necesita
  recordar la última página; si la API inserta un registro en medio, los
  desplazamientos cambian y se saltan o repiten filas.
* Cursor por id (`id > último`): solo detecta registros nuevos al final; no
  recupera huecos ni filas borradas a mano, ni ve cambios en registros viejos.
* Recarga completa en cada sincronización: simple, pero reescribe 1025 filas y
  sus relaciones cada vez, gasta datos y hace imposible distinguir "cambió" de
  "lo reescribí".
* ETag o `If-Modified-Since`: la API GraphQL no los ofrece por registro.

## Consideraciones

* La lista de ids cuesta una consulta pequeña y da la verdad exacta de qué falta,
  incluso una fila borrada a mano.
* "Sin cambios" exige tres condiciones (fila existe, hash igual, estado `ok`):
  una fila borrada conservaba su hash en `sync_meta` y se daba por buena.
* La revalidación lleva un conjunto de ids ya intentados para no ciclar si la
  API deja de devolver uno.
* El recálculo de 1025 sha1 corre en `Isolate.run` para no trabar el hilo de la
  interfaz. Las filas, los tipos y `sync_meta` se leen en una sola transacción:
  sin esa foto consistente, un lote escrito entre dos lecturas parecería un
  lote de filas borradas.
* Un recurso en `error` sin fila no se toma por borrado: la API dejó de
  devolverlo y ya lo reintenta la revalidación.

## Consecuencias

* Positivas: sincronización repetida idempotente (sin duplicados ni escrituras
  inútiles), recuperación de interrupciones y modificación en caliente
  demostrable.
* Negativas: la huella solo cubre las columnas que entran en ella; editar
  `stat_total`, rutas de imagen, habilidades, movimientos o evoluciones no se
  detecta. Un cambio remoto en esas columnas tampoco reescribe la fila hasta
  que cambie algo que sí esté en la huella.
* Negativas: un recurso sin huella en `sync_meta` (fila de `sync_meta` borrada
  o huella en NULL) queda fuera del vigilante. Una fila que la API no tiene
  (insertada a mano o con el id cambiado) no se borra: el vigilante restaura lo
  que falta o está alterado, no poda lo que sobra.
* Costo fijo: una consulta de ids por sincronización.
