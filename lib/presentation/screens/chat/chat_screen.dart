import 'package:flutter/material.dart'; // Widgets de Material Desing
import 'package:provider/provider.dart';
import 'package:yes_no_maybe_app/domain/entities/message.dart';
import 'package:yes_no_maybe_app/presentation/providers/chat_provider.dart';
import 'package:yes_no_maybe_app/presentation/widgets/chat/her_message_bubble.dart';
import 'package:yes_no_maybe_app/presentation/widgets/chat/my_message_bubble.dart';
import 'package:yes_no_maybe_app/presentation/widgets/shared/message_field.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({
    super.key,
  }); // const: se puede crear en tiempo de compilacion

  @override
  Widget build(BuildContext context) {
    // build() corre cada vez que flutter necesita dibujar este widget

    return Scaffold(
      // Scaffold da la estructura base de la pantalla
      appBar: AppBar(
        leading: Padding(
          // leading: widget en la esquina izquierda del AppBar
          padding: const EdgeInsets.all(4.0),
          child: const CircleAvatar(
            // recorta la imagen en circulo automaticamente
            backgroundImage: NetworkImage(
              'https://thumbs.dreamstime.com/b/mujer-joven-hermosa-31169854.jpg',
            ),
          ),
        ), // margen interno de 4px en los 4 lados
        title: const Text(
          'Yes No Maybe',
        ), // texto del AppBar
      ),
      body: const _ChatView(), // contenido principal, extraido a su propia clase
    );
  }
}

class _ChatView extends StatelessWidget {
  // "_" al inicio = privado, solo visible en este archivo
  const _ChatView();

  @override
  Widget build(BuildContext context) {
    final chatProvider = context
        .watch<
          ChatProvider
        >(); // se reconstruye con cada notifyListeners

    return SafeArea(
      // evita que el contenido quede bajo el notch/camara/barra de gestos
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        // symetric(horizontal: 10) = 10px de margen a izquierda y derecha
        child: Column(
          children: [
            Expanded(
              // obliga al hijo a ocupar todo el alto disponible
              child: ListView.builder(
                // construye elementos solo cuando son visibles (lazy)
                controller:
                    chatProvider.chatScrollController, // ata el auto-scroll
                itemCount: chatProvider
                    .messageList
                    .length, // ya no es 100 fijo
                itemBuilder: (context, index) {
                  // se llama una vez por cada elemento visible en pantalla
                  final message = chatProvider
                      .messageList[index]; // mensaje real

                  return message.sender ==
                          MessageSender.oracle
                      ? HerMessageBubble(message: message)
                      : MyMessageBubble(message: message); // en el Módulo 6 será una burbuja real
                },
              ),
            ),
            if (chatProvider.isOracleTyping)
              const _TypingIndicator(), // solo aparece si está cargando
            if (chatProvider.errorMessage != null)
              _ErrorBanner(
                message: chatProvider.errorMessage!, // solo aparece si hay error
              ),
            // dentro del Column, después del Expanded(ListView...):
            MessageField(
              onValue: (value) => context
                  .read<ChatProvider>()
                  .sendMessage(value),
            ),
          ],
        ),
      ),
    );
  }
}

class _TypingIndicator extends StatelessWidget {
  const _TypingIndicator();

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.centerLeft, // el oraculo "escribe" del lado izquierdo
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize
              .min, // no ocupa todo el ancho de la pantalla
          children: [
            SizedBox(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ), // spinner pequeño
            ),
            SizedBox(width: 8),
            Text('El oraculo esta pensando'),
          ],
        ),
      ),
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  final String message;
  const _ErrorBanner({required this.message});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      width:
          double.infinity, // ocupa todo el ancho disponible
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: colors.errorContainer, // color semantico de error del tema
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        message,
        style: TextStyle(
          color: colors.onErrorContainer,
        ), // legible sobre errorContainer
      ),
    );
  }
}
