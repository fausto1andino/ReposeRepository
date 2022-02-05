import 'package:flutter/material.dart';

import 'package:repose_application/src/models/sitios_model.dart';


class InfoCard extends StatelessWidget {
  const InfoCard({Key? key, required this.model}) : super(key: key);
  final Sitios model;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12.0,
      child: ListTile(
        title: Text(model.nombreSitio.toString(),
            style: Theme.of(context).textTheme.headline6),
        subtitle: Text(
            model.descripcionSitio.toString(),
            style: Theme.of(context).textTheme.subtitle2),
        trailing: Text(
            "Costo: " +
                model.costoSitio.toString() +
                " \$",
            style: Theme.of(context).textTheme.headline6),
      ),
    );
  }
}
