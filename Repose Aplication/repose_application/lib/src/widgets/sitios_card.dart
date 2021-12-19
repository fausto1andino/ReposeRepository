import 'package:flutter/material.dart';
import 'package:repose_application/src/models/fields_model.dart';

class SitiosCard extends StatelessWidget {
  const SitiosCard({Key? key, required this.model}) : super(key: key);
  final FieldsProto model;
  @override
  Widget build(BuildContext context) {
    final url = model.fieldsProto?.urlImagenSitio!.stringValue;
    return SizedBox(
      height: 500,
      child: Card(
        elevation: 50.0,
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(url.toString()), fit: BoxFit.cover)),
          child: ListTile(
              tileColor: Color.alphaBlend(Colors.amber.shade50, Colors.lime),
              title: Text(
                  model.fieldsProto!.nombreSitio!.stringValue.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.white)),
              subtitle: Text(
                  model.fieldsProto!.ciudadSitio!.stringValue.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.white)),
              trailing: const Icon(Icons.next_plan, size: 10)),
        ),
      ),
    );
  }
}
