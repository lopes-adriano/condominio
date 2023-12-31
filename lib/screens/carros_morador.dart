import 'package:brasil_fields/brasil_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CarrosMoradorScreen extends StatelessWidget {
  final String id;

  const CarrosMoradorScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carros'),
      ),
      body: CarrosList(id: id),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              String newModelo = '';
              String newMarca = '';
              String newPlaca = '';

              return AlertDialog(
                title: const Text('Adicionar Carro'),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        onChanged: (value) {
                          newModelo = value;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Modelo',
                        ),
                      ),
                      TextFormField(
                        onChanged: (value) {
                          newMarca = value;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Marca',
                        ),
                      ),
                      TextFormField(
                        inputFormatters: [PlacaVeiculoInputFormatter()],
                        onChanged: (value) {
                          newPlaca = value;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Placa',
                        ),
                      ),
                    ],
                  ),
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
                      if (newModelo.isNotEmpty &&
                          newMarca.isNotEmpty &&
                          newPlaca.isNotEmpty) {
                        FirebaseFirestore.instance
                            .collection('usuarios')
                            .doc(id)
                            .collection('carros')
                            .add({
                          'modelo': newModelo,
                          'marca': newMarca,
                          'placa': newPlaca,
                        });

                        Navigator.pop(context);
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Erro'),
                              content: const Text(
                                'Por favor, preencha todos os campos',
                              ),
                              actions: [
                                ElevatedButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
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

class CarrosList extends StatelessWidget {
  final String id;

  const CarrosList({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('usuarios')
          .doc(id)
          .collection('carros')
          .snapshots(),
      builder: (context, carrosSnapshot) {
        if (!carrosSnapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        List<DocumentSnapshot> carros = carrosSnapshot.data!.docs;

        return ListView.builder(
          itemCount: carros.length,
          itemBuilder: (context, index) {
            final carro = carros[index];
            final modelo = carro['modelo'];
            final marca = carro['marca'];
            final placa = carro['placa'];

            return ListTile(
              leading: const Icon(Icons.directions_car),
              title: Text(modelo),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [ Text('Marca: $marca'),
                  Text('Placa: $placa'),
                ],
              ),
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
    );
  }
}
