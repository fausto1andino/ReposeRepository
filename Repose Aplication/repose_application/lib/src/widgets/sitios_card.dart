import 'package:flutter/material.dart';
import 'package:repose_application/src/models/fields_model.dart';

class SitiosCard extends StatelessWidget {
  const SitiosCard({Key? key, required this.model}) : super(key: key);
  final FieldsProto model;
  @override
  Widget build(BuildContext context) {
    final url = model.fieldsProto?.urlImagenSitio!.stringValue;
    return Card(
      elevation: 12.0,
      child: Container(
        decoration: BoxDecoration(
            image:
                DecorationImage(image: NetworkImage(url.toString()), fit: BoxFit.cover)),
        child: ListTile(
          tileColor: Color.alphaBlend(Colors.amber.shade50, Colors.lime),
          leading: Text(model.fieldsProto!.ciudadSitio!.stringValue.toString(), style: Theme.of(context).textTheme.subtitle2),
          title: Text(model.fieldsProto!.nombreSitio!.stringValue.toString(), style: Theme.of(context).textTheme.headline6),
          subtitle:
               Text(model.fieldsProto!.descripcionSitio!.stringValue.toString(), style: Theme.of(context).textTheme.subtitle2),
          trailing:
             Text(model.fieldsProto!.costoSitio!.integerValue.toString(), style: Theme.of(context).textTheme.subtitle1),
        ),
      ),
    );
  }
}
