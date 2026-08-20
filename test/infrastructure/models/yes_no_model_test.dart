import 'package:flutter_test/flutter_test.dart';
import 'package:yes_no_maybe_app/domain/entities/message.dart';
import 'package:yes_no_maybe_app/infrastructure/models/yes_no_model.dart';

void main() {
  group('YesNoModel', () {
    test('fromJson lee correctamente los campos del mapa', () {
      final json = {
        'answer': 'yes',
        'forced': false,
        'image': 'https://x.com/a.gif',
      }; // simula el JSON crudo que devolvería la API

      final model = YesNoModel.fromJson(json); // ejecuta el parseo

      expect(model.answer, 'yes');
      expect(model.forced, false);
      expect(model.image, 'https://x.com/a.gif');
    });

    test('toEntity traduce "yes" a "Sí"', () {
      const model = YesNoModel(answer: 'yes', forced: false, image: 'url');
      final message = model.toEntity(); // ejecuta el mapper

      expect(message.text, 'Sí');
      expect(message.sender, MessageSender.oracle);
      expect(message.imageUrl, 'url');
    });

    test('toEntity traduce "maybe" a "Tal vez"', () {
      const model = YesNoModel(answer: 'maybe', forced: false, image: 'url');
      expect(model.toEntity().text, 'Tal vez');
    });

    test('toEntity usa el valor crudo si la API manda algo inesperado', () {
      const model = YesNoModel(answer: 'quizás', forced: false, image: 'url');
      expect(model.toEntity().text, 'quizás'); // prueba el caso "_" del switch
    });
  });
}
