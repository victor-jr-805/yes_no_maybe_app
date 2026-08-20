import 'package:flutter/material.dart';
import 'package:yes_no_maybe_app/domain/entities/message.dart';
import 'package:yes_no_maybe_app/domain/exceptions/server_exception.dart';
import 'package:yes_no_maybe_app/infrastructure/repositories/chat_repository.dart';

class ChatProvider extends ChangeNotifier {
  final ChatRepository _repository; // dependencia inyectable
  // Se conecta al ListView.builder para moverlo automaticamente
  final ScrollController chatScrollController = ScrollController();

  // Nombra el '?' para que quede claro qué dispara la pregunta al oráculo,
  // en vez de tener el string suelto dentro del if.
  static const String _oracleTriggerChar = '?';

  ChatProvider({ChatRepository? repository})
    : _repository = repository ?? ChatRepository();

  // Estado real de la conversacion (reemplaza la lista de prueba del Modulo 6)
  final List<Message> messageList = [
    Message(
      text: 'Hola, preguntame algo que termine en "?"',
      sender: MessageSender.oracle,
    ),
  ];

  bool isOracleTyping = false; // true mientras se espera la respuesta de la API
  String? errorMessage; // null = sin error

  Future<void> sendMessage(String text) async {
    final newMessage = Message(text: text, sender: MessageSender.user);

    messageList.add(newMessage); // agrega el mensaje del usuario a la lista

    notifyListeners(); // avisa a los widgets suscritos (context.watch) que deben redibujarse
    _moveScrollToBottom();

    if (text.trim().endsWith(_oracleTriggerChar)) {
      // usa la constante, no el literal
      await _askOracle(); // solo pregunta a la API si el mensaje termina en '?'
    }
  }

  Future<void> _askOracle() async {
    isOracleTyping = true; // enciende el indicador de "escribiendo..."
    notifyListeners();

    try {
      final reply = await _repository
          .getOracleReply(); // espera la respuesta real
      messageList.add(reply); // agrega la respuesta del oraculo
    } on ServerException catch (e) {
      errorMessage = e.message; // guarda el error para mostrarlo en la UI
    } finally {
      isOracleTyping = false; // apaga el indicador, haya exito o falla
      notifyListeners();
      _moveScrollToBottom();
    }
  }

  Future<void> _moveScrollToBottom() async {
    // pequeña espera para que el widget nuevo ya exista en el arbol antes de moverse
    await Future.delayed(const Duration(milliseconds: 100));

    if (!chatScrollController.hasClients) {
      return;
    } // evita crash si la lista aún no se pintó

    chatScrollController.animateTo(
      chatScrollController.position.maxScrollExtent, // el final del scroll
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    chatScrollController
        .dispose(); // libera el controller cuando el provider se destruye
    super.dispose();
  }
}
