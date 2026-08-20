import 'package:flutter/foundation.dart' show kIsWeb; // detecta si corre en navegador

/// URL de APIs externas, centralizada en un solo lugar.
/// Si el endpoint cambia algun dia. se edita aca y en ningun otro archivo.
class ApiConstants {
  // En web usa el proxy (agrega los headers CORS que yesno.wtf no manda).
  // En nativo (Linux, Android, etc.) usa la API original directo, sin intermediarios.
  static String get yesNoBaseUrl =>
      kIsWeb ? 'https://yes-no-wtf.vercel.app/api' : 'https://yesno.wtf/api';
}
