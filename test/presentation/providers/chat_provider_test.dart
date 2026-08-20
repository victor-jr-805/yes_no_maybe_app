import 'package:flutter_test/flutter_test.dart';
import 'package:yes_no_maybe_app/domain/entities/message.dart';
import 'package:yes_no_maybe_app/domain/exceptions/server_exception.dart';
import 'package:yes_no_maybe_app/infrastructure/repositories/chat_repository.dart';
import 'package:yes_no_maybe_app/presentation/providers/chat_provider.dart';

// Fake: extiende el repositorio real pero sobrescribe el método que hace red,
// devolviendo un valor controlado por nosotros en vez de llamar a la API real.
class _FakeChatRepository extends ChatRepository {
  final bool
  shouldFail; // si true, simula el camino de error

  _FakeChatRepository({this.shouldFail = false});

  @override
  Future<Message> getOracleReply() async {
    if (shouldFail) {
      throw const ServerException(
        'fallo simulado',
      ); // simula que la API falló
    }
    return Message(
      text: 'Sí',
      sender: MessageSender.oracle,
    ); // respuesta fija de prueba
  }
}

void main() {
  group('ChatProvider', () {
    test(
      'agrega el mensaje del usuario al enviar',
      () async {
        final provider = ChatProvider(
          repository: _FakeChatRepository(),
        );
        // se inyecta el fake en vez del repositorio real (Módulo 11 lo dejó listo para esto)

        await provider.sendMessage(
          'hola',
        ); // no termina en '?'

        expect(provider.messageList.last.text, 'hola');
        expect(
          provider.messageList.last.sender,
          MessageSender.user,
        );
      },
    );

    test('pregunta al oráculo cuando el mensaje termina en "?"', () async {
      final provider = ChatProvider(
        repository: _FakeChatRepository(),
      );

      await provider.sendMessage(
        'funciona?',
      ); // sí termina en '?'

      expect(
        provider.messageList.length,
        3,
      ); // inicial + usuario + oráculo
      expect(
        provider.messageList.last.sender,
        MessageSender.oracle,
      );
      expect(
        provider.isOracleTyping,
        false,
      ); // debe apagarse al terminar
    });

    test(
      'guarda el error cuando el repositorio falla',
      () async {
        final provider = ChatProvider(
          repository: _FakeChatRepository(shouldFail: true),
        );

        await provider.sendMessage('fallará?');

        expect(provider.errorMessage, isNotNull);
        expect(
          provider.isOracleTyping,
          false,
        ); // se apaga igual gracias al finally
      },
    );
  });
}
