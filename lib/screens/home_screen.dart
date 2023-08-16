import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Controle de Acesso')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 160,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: const Text('Cadastrar usuários'),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 160,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/read_users');
                },
                child: const Text('Ver usuários'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}