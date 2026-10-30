/*Fallos de dominio. La capa de datos traduce cualquier excepción de
 infraestructura (http, GraphQL, SQLite) a uno de estos tipos, para que la
 presentación nunca vea un `SocketException` ni un DTO.*/
sealed class Failure implements Exception {
  const Failure(this.message);
  final String message;

  /// Un fallo transitorio merece reintento con backoff; uno permanente no.
  bool get isTransient => false;

  @override
  String toString() => '$runtimeType: $message';
}

/// No hay red en el dispositivo.
final class NoConnectionFailure extends Failure {
  const NoConnectionFailure([super.message = 'Sin conexión a Internet']);
  @override
  bool get isTransient => true;
}

/// Hay red, pero la API no responde, responde 5xx o se agotó el timeout.
final class ServiceUnavailableFailure extends Failure {
  const ServiceUnavailableFailure([super.message = 'Servicio no disponible']);
  @override
  bool get isTransient => true;
}

/// La API respondió 429: hay que esperar más antes de reintentar.
final class RateLimitedFailure extends Failure {
  const RateLimitedFailure([super.message = 'Demasiadas solicitudes']);
  @override
  bool get isTransient => true;
}

/// La API contestó con errores GraphQL (consulta inválida, campo inexistente).
final class GraphQLFailure extends Failure {
  const GraphQLFailure(super.message);
}

/// La respuesta llegó, pero no pasó la validación (datos parciales o rotos).
final class InvalidDataFailure extends Failure {
  const InvalidDataFailure(super.message);
}

/// Error al leer o escribir la base local.
final class StorageFailure extends Failure {
  const StorageFailure(super.message);
}
