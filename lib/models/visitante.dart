import 'dart:math';
import 'package:visitantes_condominio/data/dummy_visitantes.dart';

final Map<String, Visitante> _items = {...dummy_visitantes};

List<Visitante> get all {
  return [..._items.values];
}

int get count {
  return _items.length;
}

Visitante byIndex(int i) {
  return _items.values.elementAt(i);
}

void put(Visitante visitante) {
  if (visitante == null) {
    return;
  }

  if (visitante.id != null && visitante.id.trim().isNotEmpty) {
    _items.update(
      visitante.id,
      (_) => Visitante(
          visitante.id, visitante.name, visitante.placa, visitante.avatar),
    );
  } else {
    final id = Random().nextDouble().toString();
    _items.putIfAbsent(
      id,
      () => Visitante(id, visitante.name, visitante.placa, visitante.avatar),
    );
  }
}

void remove(Visitante visitante) {
  if (visitante != null && visitante.id != null) {
    _items.remove(visitante.id);
  }
}

class Visitante {
  final String id;
  final String name;
  final String placa;
  final String avatar;

  Visitante(
    this.id,
    this.name,
    this.placa,
    this.avatar,
  );
}
