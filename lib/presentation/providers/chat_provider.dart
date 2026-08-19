import 'package:flutter/material.dart';
import 'package:yes_no_maybe_app/domain/entities/message.dart';

class ChatProvider extends ChangeNotifier {
  // Se conecta al ListView.builder para moverlo automaticamente
  final ScrollController chatScrollController =
      ScrollController();

  // Estado real de la conversacion (reemplaza la lista de prueba del Modulo 6)
  final List<Message> messageList = [
    Message(
      text: 'Hola, preguntame algo que termine en "?"',
      sender: MessageSender.oracle,
    ),
  ];

  Future<void> sendMessage(String text) async {
    final newMessage = Message(
      text: text,
      sender: MessageSender.user,
    );
    messageList.add(
      newMessage,
    ); // agrega el mensaje nuevo a la lista

    notifyListeners(); // avisa a los widgets suscritos (context.watch) que deben redibujarse

    _moveScrollToBottom();
  }

  Future<void> _moveScrollToBottom() async {
    // pequeña espera para que el widget nuevo ya exista en el arbol antes de moverse
    await Future.delayed(const Duration(milliseconds: 100));

    if (!chatScrollController.hasClients)
      return; // evita crash si la lista aún no se pintó

    chatScrollController.animateTo(
      chatScrollController
          .position
          .maxScrollExtent, // el final del scroll
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    chatScrollController.dispose(); // libera el controller cuando el provider se destruye
    super.dispose();
  }
}
