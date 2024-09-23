import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  TelaLoginState createState() => TelaLoginState();
}

class TelaLoginState extends State<TelaLogin> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  String token = '';

  Future<void> login() async {
    final response = await http.post(
      Uri.parse('http://demo9168476.mockable.io/login'),
      body: jsonEncode({
        'nome': _nomeController.text,
        'senha': _senhaController.text,
      }),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        token = data['token'];
      });
      Navigator.pushNamed(context, '/notasAlunos', arguments: token);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tela de Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _senhaController,
              decoration: const InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: login,
              child: const Text('Login'),
            ),
            const SizedBox(height: 20),
            if (token.isNotEmpty) Text('Token: $token'),
          ],
        ),
      ),
    );
  }
}
