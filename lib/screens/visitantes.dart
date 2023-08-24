import 'package:brasil_fields/brasil_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VisitantesScreen extends StatelessWidget {
  final String id;

  const VisitantesScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visitantes'),
      ),
      body: VisitantesList(id: id,),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              String newName = '';
              String newCar = '';
              String newPlate = '';

              return AlertDialog(
                title: const Text('Adicionar Visitante'),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        onChanged: (value) {
                          newName = value;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Nome',
                        ),
                      ),
                      TextFormField(
                        onChanged: (value) {
                          newCar = value;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Carro',
                        ),
                      ),
                      TextFormField(
                        inputFormatters: [PlacaVeiculoInputFormatter()],
                        onChanged: (value) {
                          newPlate = value;
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
                      if (newName.isNotEmpty &&
                          newCar.isNotEmpty &&
                          newPlate.isNotEmpty) {
                        FirebaseFirestore.instance
                            .collection('usuarios')
                            .doc(id)
                            .collection('visitantes')
                            .add({
                          'nome': newName,
                          'carro': newCar,
                          'placa': newPlate,
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

class VisitantesList extends StatelessWidget {
  
  final String id;

  const VisitantesList({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('usuarios')
          .doc(id)
          .collection('visitantes')
          .snapshots(),
      builder: (context, visitantesSnapshot) {
        if (!visitantesSnapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        List<DocumentSnapshot> visitantes = visitantesSnapshot.data!.docs;

        return ListView.builder(
          itemCount: visitantes.length,
          itemBuilder: (context, index) {
            final visitante = visitantes[index];
            final nome = visitante['nome'];
            final carro = visitante['carro'];
            final placa = visitante['placa'];

            return ListTile(
              leading: const Icon(Icons.person),
              title: Text(nome),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Carro: $carro'),
                  Text('Placa: $placa'),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection('usuarios')
                      .doc(id)
                      .collection('visitantes')
                      .doc(visitante.id)
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

