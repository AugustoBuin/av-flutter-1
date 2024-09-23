import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TelaNotas extends StatefulWidget {
  final String token;

  const TelaNotas({super.key, required this.token});

  @override
  TelaNotasState createState() => TelaNotasState();
}

class TelaNotasState extends State<TelaNotas> {
  List alunos = [];
  List alunosFiltrados = [];

  Future<void> fetchNotas() async {
    final response =
        await http.get(Uri.parse('http://demo9168476.mockable.io/notasAlunos'));
    if (response.statusCode == 200) {
      setState(() {
        alunos = jsonDecode(response.body);
        alunosFiltrados = alunos;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchNotas();
  }

  void filtrarAlunos(double min, double max) {
    setState(() {
      alunosFiltrados = alunos.where((aluno) {
        return aluno['nota'] >= min && aluno['nota'] < max;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notas dos Alunos')),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => filtrarAlunos(0, 60),
                child: const Text('Nota < 60'),
              ),
              ElevatedButton(
                onPressed: () => filtrarAlunos(60, 100),
                child: const Text('Nota >= 60'),
              ),
              ElevatedButton(
                onPressed: () => filtrarAlunos(100, 101),
                child: const Text('Nota = 100'),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: alunosFiltrados.length,
              itemBuilder: (context, index) {
                final aluno = alunosFiltrados[index];
                final cor = aluno['nota'] == 100
                    ? Colors.green
                    : aluno['nota'] >= 60
                        ? Colors.blue
                        : Colors.yellow;
                return Container(
                  color: cor,
                  child: ListTile(
                    title: Text('${aluno['nome']} - Nota: ${aluno['nota']}'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
