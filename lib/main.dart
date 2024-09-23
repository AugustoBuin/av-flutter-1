import 'package:flutter/material.dart';

import 'inicio.dart';
import 'list_notas.dart';
import 'login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const TelaInicial(),
        '/login': (context) => const TelaLogin(),
        '/notasAlunos': (context) => TelaNotas(
            token: ModalRoute.of(context)!.settings.arguments as String),
      },
    );
  }
}
