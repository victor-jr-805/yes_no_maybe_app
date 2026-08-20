import 'package:flutter/material.dart';
import 'package:yes_no_maybe_app/domain/entities/message.dart';

class HerMessageBubble extends StatelessWidget {
  final Message
  message; // el mensaje que este widget debe mostrar
  const HerMessageBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context)
        .colorScheme; // Paleta generada en el modulo 3
    return Column(
      crossAxisAlignment: CrossAxisAlignment
          .start, // alinea a la derecha = mensaje propio
      children: [
        Container(
          decoration: BoxDecoration(
            color: colors.secondary, // Color distinto al de "mis" mensajes
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
                color: colors.onSecondary,
              ), // Legible SOBRE colors.secondary
            ),
          ),
        ),
        if (message.imageUrl != null) ...[
          // solo agrega la imagen si el mensaje realmente trae una
          const SizedBox(height: 5),
          _ImageBubble(message.imageUrl!),
        ] else
          const SizedBox(height: 10),
      ],
    );
  }
}

class _ImageBubble extends StatelessWidget {
  final String imageUrl;

  const _ImageBubble(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context)
        .size; // ancho/alto de la pantalla actual
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        20,
      ), // recorta la imagen en esquinas redoondeadas
      child: Image.network(
        imageUrl,
        width: size.width * 0.6, // 60% del ancho, se adapta a cualquier tamaño de pantalla
        height: 180,
        fit: BoxFit.cover, // recorta el sobrante sin deformar la imagen
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } // Ya termino la carga
          return Container(
            width: size.width * 0.6,
            height: 180,
            alignment: Alignment.center,
            child: const CircularProgressIndicator(), // feedback visual mientras descarga
          );
        },
      ),
    );
  }
}
