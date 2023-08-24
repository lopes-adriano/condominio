import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Controle de Acesso')),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RedirectButton(text: 'Cadastrar usuários', route: '/signup'),
            RedirectButton(text: 'Buscar usuários', route: '/read_users'),
            RedirectButton(text: 'Gerenciar carros', route: '/carros_morador'),
          ],
        ),
      ),
    );
  }
}

class RedirectButton extends StatelessWidget {

  final String text;
  final String route;

  const RedirectButton({
    super.key, required this.text, required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
        child:  Text(text),
      ),  
    );
  }
}