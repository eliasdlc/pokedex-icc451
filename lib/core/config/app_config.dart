abstract final class AppConfig {
  static const graphqlEndpoint = 'https://graphql.pokeapi.co/v1beta2';

  // Solo ASCII: un encabezado HTTP con tildes lanza FormatException.
  static const userAgent =
      'PokedexICC451/1.0 (Flutter; PUCMM academic project)';

  static const requestTimeout = Duration(seconds: 12);

  /// Timeout de la sonda de salud: si la API no contesta en esto, se
  /// considera "servicio no disponible" aunque haya red.
  static const healthProbeTimeout = Duration(seconds: 5);

  /// Backoff exponencial: 4 intentos en total; entre ellos espera 0.5 s, 1 s
  /// y 2 s. Si el cuarto falla, se rinde.
  static const maxRetryAttempts = 4;
  static const retryBaseDelay = Duration(milliseconds: 500);

  /// Tamaño de cada lote del delta del catálogo: se piden los ids que faltan
  /// de 100 en 100 con `_in`.
  static const catalogBatchSize = 100;

  /// Política de vigencia: un registro sincronizado hace más de esto se
  /// revalida en segundo plano comparando su hash con el remoto.
  static const freshnessTtl = Duration(days: 7);

  /// Cada cuánto el vigilante de integridad recalcula los hashes locales para
  /// detectar una modificación en caliente de la base.
  static const integrityInterval = Duration(seconds: 20);

  /// Cada cuánto se vuelve a sondear la API mientras no esté en línea.
  static const reconnectProbeInterval = Duration(seconds: 15);

  /// IND-06: cuánto se espera para confirmar una pérdida de red antes de
  /// pasar el indicador a "Sin conexión" (evita parpadeos en cortes breves).
  static const offlineGrace = Duration(seconds: 2);

  /// Ventana del debounce de búsqueda (el enunciado pide 300 a 500 ms).
  static const searchDebounce = Duration(milliseconds: 350);

  /// Presupuesto de escritura de un favorito (el enunciado pide < 150 ms).
  static const favoriteWriteBudget = Duration(milliseconds: 150);

  /// Descargas de imágenes en paralelo durante la sincronización.
  static const imageDownloadConcurrency = 4;

  /// Interruptor de depuración para simular la caída de la API (PA-08).
  /// Se activa también desde la pantalla Laboratorio sin recompilar.
  static const simulateApiDownFromBuild = bool.fromEnvironment(
    'SIMULATE_API_DOWN',
  );
}
