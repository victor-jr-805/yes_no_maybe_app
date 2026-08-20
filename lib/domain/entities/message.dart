/// Quién envió el mensaje dentro de la conversación.
///
/// Un enum en vez de un String elimina una categoría entera de bugs:
/// con String, un typo compila sin errores y falla en tiempo de
/// ejecución. Con enum, el analizador lo detecta al instante.
enum MessageSender { user, oracle }

/// Representa un único mensaje dentro del chat.
///
/// Vive en la capa `domain`: no importa Flutter, Dio, ni ningún
/// paquete externo. Es Dart puro — se podría reutilizar tal cual
/// en un backend, en un test, o en otro cliente (móvil, escritorio).
class Message {
  final String text;
  final MessageSender sender;
  final String? imageUrl;

  Message({required this.text, required this.sender, this.imageUrl});
}
