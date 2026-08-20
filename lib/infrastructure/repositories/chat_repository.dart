import 'package:yes_no_maybe_app/domain/entities/message.dart';
import 'package:yes_no_maybe_app/infrastructure/datasources/yes_no_datasource.dart';

// Unico punto que 'presentation' conoce para depir datos.
// No expone YesNoModel ni Dio, solo entidades del mominio.

class ChatRepository {
  final YesNoDatasource _datasource; // fuente de datos real (o falsa, en tests)

  ChatRepository({YesNoDatasource? datasource})
    : _datasource = datasource ?? YesNoDatasource();
  // Si no se inyecta nada, usa el datasource real por defecto

  Future<Message> getOracleReply() async {
    final model = await _datasource.getAnswer(); // pide el modelo crudo
    return model.toEntity(); // devuelve la entidad ya mapeada, nunca el modelo
  }
}
