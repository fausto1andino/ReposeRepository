import 'package:flutter/material.dart';
import 'package:repose_application/src/models/fields_model.dart';


class SitiosCard extends StatelessWidget {
  const SitiosCard({Key? key, required this.model}) : super(key: key);
  final FieldsProto model;
  @override
  Widget build(BuildContext context) {
     final url = model.fieldsProto?.urlImagenSitio!.stringValue;
    return Card(
                 elevation: 7.0,
                      child: ListTile(
            
                           leading: CircleAvatar(backgroundImage: NetworkImage(url.toString())),
                          title: Text(model.fieldsProto!.nombreSitio!.stringValue.toString()),
                          subtitle: Text(model.fieldsProto!.descripcionSitio!.stringValue.toString()),
                            trailing:  Text(model.fieldsProto!.ciudadSitio!.stringValue.toString()),
                                  ),
                    );
  }
}