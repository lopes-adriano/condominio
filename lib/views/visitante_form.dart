import 'dart:js';

import 'package:flutter/material.dart';
import 'package:visitantes_condominio/models/visitante.dart';

class VisitanteForm extends StatelessWidget {
  VisitanteForm({super.key});
  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  void _loadFormData(Visitante visitante) {
    if (visitante != null) {
      _formData['id'] = visitante.id;
      _formData['name'] = visitante.name;
      _formData['placa'] = visitante.placa;
      _formData['avatar'] = visitante.avatar;
    }
  }

  @override
  Widget build(BuildContext context) {
    final visitante = ModalRoute.of(context)?.settings.arguments as Visitante;

    _loadFormData(visitante);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de visitante'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              final isValid = _form.currentState!.validate();
              if (isValid) {
                _form.currentState?.save();
                put(Visitante(
                  visitante.id,
                  visitante.name,
                  visitante.placa,
                  visitante.avatar,
                ));
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _formData['name'],
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nome inválido';
                  }

                  return null;
                },
                onSaved: (value) => _formData['name'] = value!,
              ),
              TextFormField(
                initialValue: _formData['placa'],
                decoration: const InputDecoration(labelText: 'Placa'),
                onSaved: (value) => _formData['placa'] = value!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
