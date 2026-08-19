import 'package:flutter/material.dart';

/// Colores semilla disponibles para generar el esquema de color de la app.
/// Cada uno genera automáticamente una paleta tonal completa (Material 3).
const List<Color> _colorSeeds = [
  Color(0xFF5C11D4), // 0: morado personalizado
  Colors.blue, // 1
  Colors.green, // 2
  Colors.amber, // 3
  Colors.orange, // 4
  Colors.pink, // 5
];

class AppTheme {
  final int selectedColor;

  AppTheme({this.selectedColor = 0})
    : assert(
        selectedColor >= 0 &&
            selectedColor < _colorSeeds.length,
        'selectedColor debe estar entre 0 y ${_colorSeeds.length - 1}',
      );

  ThemeData theme() {
    return ThemeData(
      colorSchemeSeed: _colorSeeds[selectedColor],
    );
  }
}
