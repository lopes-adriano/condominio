import 'package:flutter/material.dart';
import 'package:visitantes_condominio/models/visitante.dart';
import 'package:visitantes_condominio/routes/app_routes.dart';

class VisitanteTile extends StatelessWidget {
  final Visitante visitante;
  const VisitanteTile(this.visitante);

  @override
  Widget build(BuildContext context) {
    final avatar = visitante.avatar == null || visitante.avatar.isEmpty
        ? const CircleAvatar(child: Icon(Icons.car_crash))
        : CircleAvatar(backgroundImage: NetworkImage(visitante.avatar));

    return ListTile(
      leading: avatar,
      title: Text(visitante.name),
      subtitle: Text(visitante.placa),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.edit),
              color: Colors.blue,
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.visitanteForm,
                  arguments: visitante,
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              color: Colors.red,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Excluir veículo'),
                    content: const Text('Confirmar?'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Não'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Sim'),
                        onPressed: () {
                          remove(visitante);
                          Navigator.of(context)
                              .pop(); // Feche o diálogo após a exclusão
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
