import 'package:flutter/material.dart';
import 'package:yes_no_maybe_app/domain/entities/message.dart';

class MyMessageBubble extends StatelessWidget {
  final Message
  message; // el mensaje que este widget debe mostrar
  const MyMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context)
        .colorScheme; // Paleta generada en el modulo 3
    return Column(
      crossAxisAlignment: CrossAxisAlignment
          .end, // alinea a la derecha = mensaje propio
      children: [
        Container(
          decoration: BoxDecoration(
            color: colors.primary, // cambia solo con el seed del tema. No esta fijo
            borderRadius: BorderRadius.circular(
              10,
            ), // esquinas redondeadas
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            child: Text(
              message.text, // texto real, ya no un string de prueba fijo
              style: TextStyle(
                color: colors.onPrimary,
              ), // Legible SOBRE colors.primary
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ), // Separacion entre una burbuja y la siguiente
      ],
    );
  }
}

