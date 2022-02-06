import 'package:flutter/material.dart';
import 'package:repose_application/src/utils/main_menu.dart';

class TableroWidget extends StatelessWidget {
  const TableroWidget({Key? key, required this.titulo, required this.descripcion}) : super(key: key);
  final MenuItem titulo;
  final String descripcion;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
          margin: const EdgeInsets.all(7.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(titulo.icon, size: 50.0),
              Text(titulo.label, style: Theme.of(context).textTheme.headline6),
              Container(
                margin: const EdgeInsets.all(20.0),
                child: Text(descripcion,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText2),
              ),
            ],
          )),
    );
  }
}