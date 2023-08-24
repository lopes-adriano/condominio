import 'package:flutter/material.dart';
import 'package:visitantes_condominio/routes/app_routes.dart';
import 'package:visitantes_condominio/models/visitante.dart';
import 'package:visitantes_condominio/components/visitante_tile.dart';

class MeusVisitantesList extends StatelessWidget {
  const MeusVisitantesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Meus visitantes')),
        backgroundColor: Colors.deepPurple,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRoutes.visitanteForm,
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: count,
        itemBuilder: (ctx, i) => VisitanteTile(byIndex(i)),
      ),
    );
  }
}
