import 'package:flutter/material.dart'; // Widgets de Material Desing
import 'package:yes_no_maybe_app/domain/entities/message.dart';
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
                itemCount: 100, // total de elementos (placeholder por ahora)
                itemBuilder: (context, index) {
                  // se llama una vez por cada elemento visible en pantalla
                  final isOracle = index.isEven; // alterna oraculo/usuario para probar ambas burbujas
                  final message = Message(
                    text: 'Mensaje de prueba $index',
                    sender: isOracle
                        ? MessageSender.oracle
                        : MessageSender.user,
                    // solo el primer mensaje del oraculo trae imagen, para probar _ImageBubble
                    imageUrl: (isOracle && index == 0)
                        ? 'https://yesno.wtf/assets/no/27-8befe9bcaeb66f865dd3ecdcf8821f51.gif'
                        : null,
                  );
                  return isOracle
                      ? HerMessageBubble(message: message)
                      : MyMessageBubble(message: message); // en el Módulo 6 será una burbuja real
                },
              ),
            ),
            
            // dentro del Column, después del Expanded(ListView...):
            MessageField(
              onValue: (value) {
                debugPrint('Mensaje enviado: $value'); // placeholder — se conecta al provider en el Módulo 8
              },
            ),
          ],
        ),
      ),
    );
  }
}
