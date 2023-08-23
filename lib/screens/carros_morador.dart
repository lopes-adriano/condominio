import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CarrosMoradorScreen extends StatelessWidget {
  final String id;

  const CarrosMoradorScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carros'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('usuarios')
            .doc(id)
            .collection('carros')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          List<DocumentSnapshot> carros = snapshot.data!.docs;

          return ListView.builder(
            itemCount: carros.length,
            itemBuilder: (context, index) {
              final carro = carros[index];
              final modelo = carro['modelo'];
              final placa = carro['placa'];

              return ListTile(
                title: Text(modelo),
                subtitle: Text(placa),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection('usuarios')
                        .doc(id)
                        .collection('carros')
                        .doc(carro.id)
                        .delete();
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              String novoModelo = '';
              String novaPlaca = '';

              return AlertDialog(
                title: const Text('Adicionar Carro'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      onChanged: (value) {
                        novoModelo = value;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Modelo',
                      ),
                    ),
                    TextFormField(
                      inputFormatters: [PlacaVeiculoInputFormatter()],
                      onChanged: (value) {
                        novaPlaca = value;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Placa',
                      ),
                    ),
                  ],
                ),
                actions: [
                  ElevatedButton(
                    child: const Text('Cancelar'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  ElevatedButton(
                    child: const Text('Adicionar'),
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection('usuarios')
                          .doc(id)
                          .collection('carros')
                          .add({
                        'modelo': novoModelo,
                        'placa': novaPlaca,
                      });

                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
