/// Excepcion propia del dominio para errores de red/servidor.
/// Vive en 'domain' (no en 'infraestructure') porque tanto infra como
/// presentation necesitan poder usarla, y domain es lo unico que ambos
/// pueden importar segun la regla de dependencias.
class ServerException implements Exception {
  final String message;
  const ServerException(this.message);

  @override
  String toString() => 'ServerException: $message'; // texto legible si se imprime
}
