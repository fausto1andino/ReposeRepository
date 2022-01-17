import 'package:flutter/material.dart';
import 'package:repose_application/src/models/fields_model.dart';
import 'package:repose_application/src/widgets/sugerencia_list_widget.dart';

class SitiosCard extends StatelessWidget {
  const SitiosCard({Key? key, required this.model}) : super(key: key);
  final FieldsProto model;

  @override
  Widget build(BuildContext context) {
    final url = model.fieldsProto?.urlImagenSitio!.stringValue;
    return SizedBox(
      height: 500,
      width: 300,
      child: Card(
        elevation: 20.0,
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(url.toString()), fit: BoxFit.cover)),
          child: ListTile(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          title: Text(
                              model.fieldsProto!.nombreSitio!.stringValue
                                  .toString(),
                              style: Theme.of(context).textTheme.headline6),
                          content: Text(
                              model.fieldsProto!.descripcionSitio!.stringValue
                                  .toString(),
                              style: Theme.of(context).textTheme.subtitle2),
                      actions: [
                        TextButton(
                            child: const Text(
                              'Sugerencia',
                              textAlign: TextAlign.center,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SugerenciaWidget()),
                              );
                            })
                      ],
                        );
                    }
                        
                        );
              },
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
              trailing: Text(
                  "Costo: " +
                      model.fieldsProto!.costoSitio!.integerValue.toString() +
                      " \$",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.white))),
        ),
      ),
    );
  }
}
