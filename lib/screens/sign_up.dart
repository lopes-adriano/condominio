import 'package:condominio/user_form.dart';
import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  const SignUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Cadastrar usuário')),
      ),
      body:  const SingleChildScrollView(
        child: UserFieldsForm(),
      ),
    );
  }
}
