import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yes_no_maybe_app/presentation/widgets/shared/message_field.dart';

void main() {
  testWidgets(
    'MessageField llama a onValue y limpia el campo al enviar',
    (tester) async {
      String? sentValue; // aquí guardamos lo que el widget nos devuelva

      await tester.pumpWidget(
        MaterialApp(
          // MessageField usa Theme.of() internamente, necesita este contexto
          home: Scaffold(
            body: MessageField(
              onValue: (value) => sentValue = value,
            ),
          ),
        ),
      );

      await tester.enterText(
        find.byType(TextFormField),
        'hola?',
      ); // simula escribir
      await tester.tap(
        find.byIcon(Icons.send),
      ); // simula tocar el botón de enviar
      await tester.pump(); // procesa el frame resultante de esa acción

      expect(
        sentValue,
        'hola?',
      ); // el callback recibió el texto correcto
      expect(
        find.text('hola?'),
        findsNothing,
      ); // el campo quedó vacío después de enviar
    },
  );
}
