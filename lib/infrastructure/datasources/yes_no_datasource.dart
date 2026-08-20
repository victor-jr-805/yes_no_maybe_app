import 'package:dio/dio.dart';
import 'package:yes_no_maybe_app/config/constants/api_constants.dart';
import 'package:yes_no_maybe_app/domain/exceptions/server_exception.dart';
import 'package:yes_no_maybe_app/infrastructure/models/yes_no_model.dart';

/// Obtiene la respuesta cruda (JSON) de la API pública yesno.wtf.
/// No sabe nada de `Message`; eso es responsabilidad del mapper.
class YesNoDatasource {
  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(
        seconds: 5,
      ), // maximo para establecer conexion
      receiveTimeout: const Duration(
        seconds: 5,
      ), // maximo esperando la respuesta
    ),
  );

  Future<YesNoModel> getAnswer() async {
    try {
      final response = await _dio.get(
        ApiConstants.yesNoBaseUrl,
      ); // espera la peticion GET
      return YesNoModel.fromJson(
        response.data as Map<String, dynamic>,
      ); // dio ya decodifica el JSON por nosotros
    } on DioException catch (e) {
      // convertimos el error de Dio en nuestra propia excepcion de dominio
      throw ServerException(
        'No se puedo obtener respuesta del oraculo: ${e.message}',
      );
    }
  }
}
