import 'package:flutter/material.dart';

class MessageField extends StatefulWidget {
  final ValueChanged<String>
  onValue; // se ejecuta cuando el usuario envia un mensaje
  const MessageField({super.key, required this.onValue});

  @override
  State<MessageField> createState() => _MessageFieldState();
  // conecta este widget inmutable con su State mutable de abajo
}

class _MessageFieldState extends State<MessageField> {
  // Todo lo que este aqui SOBREVIVE a cada rebuild, a diferencia del bug original

  late final TextEditingController _textController;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState(); // siempre se llama primero
    _textController = TextEditingController(); // Se crea una sola vez, no en cada build
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _textController.dispose(); // Libera memoria del controller
    _focusNode.dispose(); // libera memoria del focus node
    super.dispose(); // siempre se llama al final
  }

  void _handleSubmit(String value) {
    if (value.trim().isEmpty) {
      return;
    } // ignora mensajes vacios o solo espacios
    widget.onValue(
      value,
    ); // Avisa al padre (mas adelante, al ChatProvider)
    _textController.clear(); // Limpia la caja de texto
    _focusNode.requestFocus(); // mantiene el teclado abierto para seguir escribiendo
  }

  @override
  Widget build(BuildContext context) {
    final border = UnderlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(20),
    );
    return TextFormField(
      controller: _textController, // el mismo controller en cada build, no uno nuevo
      focusNode: _focusNode,
      onTapOutside: (event) =>
          _focusNode.unfocus(), // cierra teclado al tocar afuera
      onFieldSubmitted: _handleSubmit, // Enter/Done del teclado
      decoration: InputDecoration(
        hintText: 'Termina tu mensaje con un "?"',
        enabledBorder: border,
        focusedBorder: border,
        filled: true,
        suffixIcon: IconButton(
          tooltip: 'Enviar mensaje', // descripcion para lectores de pantalla / hover
          onPressed: () => _handleSubmit(
            _textController.text,
          ), // mismo flujo que Enter
          icon: Icon(Icons.send),
        ),
      ),
    );
  }
}
