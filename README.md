# 🔮 Yes No Maybe App

App de chat en Flutter que responde tus preguntas de sí/no con un oráculo caprichoso, consumiendo la API pública [yesno.wtf](https://yesno.wtf).

![Flutter](https://img.shields.io/badge/Flutter-3.44-02569B?logo=flutter&logoColor=white)
![License](https://img.shields.io/badge/license-MIT-green)
![Platforms](https://img.shields.io/badge/platforms-Web%20%7C%20Android%20%7C%20Linux-blue)

## Demo

<!-- Grabacion hecha con kooha -->

![demo](docs/demo.gif)

## Características

- Interfaz de chat con burbujas propias y del "oráculo"
- Respuestas sí / no / tal vez con imagen animada
- Manejo de estados de carga y error
- Funciona en Web, Android y Linux (Windows/macOS/iOS en el roadmap)

## Arquitectura

Proyecto organizado por capas, siguiendo la regla de dependencia unidireccional:

```
lib/
├── domain/          # Entidades y reglas de negocio, sin dependencias externas
├── infrastructure/   # Modelos, datasource (Dio) y repositorio
└── presentation/     # Pantallas, widgets y estado (Provider)
```

## Stack técnico

- [Flutter](https://flutter.dev) 3.44 / Dart 3
- [Provider](https://pub.dev/packages/provider) — manejo de estado
- [Dio](https://pub.dev/packages/dio) — cliente HTTP
- Material 3

## Cómo correrlo localmente

```bash
git clone https://github.com/victor-jr-805/yes_no_maybe_app.git
cd yes_no_maybe_app
flutter pub get
flutter run -d chrome   # o -d linux, o el id de tu dispositivo
```

## Tests

```bash
flutter test
```

## Licencia

MIT — ver [LICENSE](LICENSE).
