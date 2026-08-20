import 'package:flutter_test/flutter_test.dart';
import 'package:yes_no_maybe_app/domain/entities/message.dart';

void main() {
  test('Message guarda correctamente sus campos', () {
    final message = Message(
      text: 'hola',              // texto de prueba
      sender: MessageSender.user, // remitente de prueba
      imageUrl: null,             // sin imagen para este caso
    );

    expect(message.text, 'hola');            // verifica el texto
    expect(message.sender, MessageSender.user); // verifica el remitente
    expect(message.imageUrl, isNull);         // verifica que quedó null
  });
}
