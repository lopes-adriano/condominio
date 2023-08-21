import 'dart:async';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class UserFieldsForm extends StatefulWidget {
  const UserFieldsForm({super.key});

  @override
  State<UserFieldsForm> createState() => _UserFieldsFormState();
}

class _UserFieldsFormState extends State<UserFieldsForm> {
  final _formKey = GlobalKey<FormState>();
  String? userType;
  String nome = '';
  String cpf = '';
  String email = '';
  String? apartamento;
  bool formSubmitted = false;

  final maskCpf = MaskTextInputFormatter(
      mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')});

  Future createUser(
      {required String nome,
      required String cpf,
      required String email,
      required String? userType,
      String? apartamento}) async {
    final docUser = FirebaseFirestore.instance.collection('usuarios').doc();
    final data = <String, dynamic>{
      'nome': nome,
      'cpf': cpf,
      'email': email,
      'tipoUsuario': userType,
      if (apartamento != null)
      'apartamento': apartamento,
    };
    await docUser.set(data);

    setState(() {
      formSubmitted = true;
    });

    Timer(const Duration(seconds: 3), () {
      setState(() {
        formSubmitted = false;
      });
      _formKey.currentState!.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Nome'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, digite o nome';
                }
                return null;
              },
              onSaved: (value) {
                nome = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'CPF'),
              inputFormatters: [maskCpf],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, digite o CPF';
                }
                if (UtilBrasilFields.isCPFValido(value) == false) {
                  return 'Por favor, digite um CPF válido';
                }
                return null;
              },
              onSaved: (value) {
                cpf = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, digite um email';
                }
                if (!EmailValidator.validate(value)) {
                  return 'Digite um email válido';
                }
                return null;
              },
              onSaved: (value) {
                email = value!;
              },
            ),
            DropdownButtonFormField<String>(
              value: userType,
              decoration: const InputDecoration(labelText: 'Tipo de usuário'),
              items: const [
                DropdownMenuItem(
                  value: 'morador',
                  child: Text('Morador'),
                ),
                DropdownMenuItem(
                  value: 'controle',
                  child: Text('Controle de Acesso'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  userType = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Selecione o tipo de usuário';
                }
                return null;
              },
            ),
            if (userType == 'morador')
              TextFormField(
                decoration: const InputDecoration(labelText: 'Apartamento'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o apartamento';
                  }
                  return null;
                },
                onSaved: (value) {
                  apartamento = value!;
                },
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  createUser(
                      nome: nome,
                      cpf: cpf,
                      email: email,
                      apartamento: apartamento, 
                      userType: userType);
                }
              },
              child: const Text('Cadastrar'),
            ),
            if (formSubmitted)
              const Text(
                'Cadastro realizado!',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
