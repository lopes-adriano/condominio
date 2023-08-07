// Essa classe não está sendo utilizada por enquanto

import 'package:condominio/usuario.dart';

class Morador extends User {
  final String apartamento;

  Morador({
    required String name,
    required String cpf,
    required String email,
    required this.apartamento,
  }) : super(
          userType: 'morador',
          name: name,
          cpf: cpf,
          email: email,
        );
}