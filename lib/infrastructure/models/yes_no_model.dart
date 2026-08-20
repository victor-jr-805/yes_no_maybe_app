import 'package:yes_no_maybe_app/domain/entities/message.dart';

class YesNoModel {
  final String
  answer; // 'yes | 'np' | 'maybe', tal cual lo manda la API
  final bool forced;
  final String image;

  const YesNoModel({
    required this.answer,
    required this.forced,
    required this.image,
  });

  // factory: recibe el Map crudo del JSON y construye el modelo
  factory YesNoModel.fromJson(Map<String, dynamic> json) {
    return YesNoModel(
      answer: json['answer'] as String, // 'as String' valida el tipo en tiempo de ejecucion
      forced: json['forced'] as bool,
      image: json['image'] as String,
    );
  }

  // MAPPER: convierte este modelo (infra) en una entidad Message (domain)
  Message toEntity() {
    final text = switch (answer) {
      'yes' => 'Si',
      'no' => 'No',
      'maybe' => 'Tal vez',
      _ => answer, // fallback defencibo si la API algun dia cambia el valor
    };

    return Message(
      text: text,
      sender: MessageSender.oracle,
      imageUrl: image,
    );
  }
}
