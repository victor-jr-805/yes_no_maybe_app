import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_no_maybe_app/config/theme/app_theme.dart';
import 'package:yes_no_maybe_app/presentation/providers/chat_provider.dart';
import 'package:yes_no_maybe_app/presentation/screens/chat/chat_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ChatProvider(),
        ), // Crea UNA instancia para toda la App
      ],
      child: MaterialApp(
        title: 'Yes No Maybe App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme(selectedColor: 1).theme(),
        home: const ChatScreen(), // reemplaza el Scaffold temporal del modulo 3
      ),
    );
  }
}
