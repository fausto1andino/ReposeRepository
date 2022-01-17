import 'package:flutter/material.dart';
import 'package:repose_application/src/models/sugerencia_model.dart';

class SugerenciaCard extends StatelessWidget {
  const SugerenciaCard({Key? key, required this.model}) : super(key: key);
  final Sugerencia model;
  @override
  Widget build(BuildContext context) {
      final icon = model.valoracion == 4
        ? const Icon(Icons.score, color: Colors.red)
        : model.valoracion == 3
              ? const Icon(Icons.score, color: Colors.orange)
              : model.valoracion == 2
              ? const Icon(Icons.score, color: Colors.amber)
              : model.valoracion == 1
              ? const Icon(Icons.score, color: Colors.yellow)
              : model.valoracion == 0
              ? const Icon(Icons.score, color: Colors.green): 
              const Icon(Icons.error);
          
    return Card(
        child: ListTile(
            trailing: icon,
            leading: Text(model.id.toString()),
            title: Text(model.titulo),
            subtitle: Text(model.comentario)));
  }
}
