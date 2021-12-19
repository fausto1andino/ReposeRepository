import 'package:flutter/material.dart';
import 'package:repose_application/src/models/fields_model.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({Key? key, required this.model}) : super(key: key);
  final FieldsProto model;
  @override
  Widget build(BuildContext context) {
    final url = model.fieldsProto?.urlImagenSitio!.stringValue;
    return Card(
      elevation: 12.0,
      child: ListTile(
        tileColor: Color.alphaBlend(Colors.amber.shade50, Colors.lime),
        title: Text(model.fieldsProto!.nombreSitio!.stringValue.toString(),
            style: Theme.of(context).textTheme.headline6),
        subtitle: Text(
              model.fieldsProto!.descripcionSitio!.stringValue.toString(),
              style: Theme.of(context).textTheme.subtitle2),
        
        trailing: Text(
            "Costo: " +
                model.fieldsProto!.costoSitio!.integerValue.toString() +
                " \$",
            style: Theme.of(context).textTheme.headline6),
      ),
    );
  }
}
