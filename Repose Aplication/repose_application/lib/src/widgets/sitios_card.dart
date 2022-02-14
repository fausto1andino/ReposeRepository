import 'package:flutter/material.dart';
import 'package:repose_application/src/models/sitios_model.dart';
import 'package:repose_application/src/pages/request_permission/request_permission_page.dart';
import 'package:repose_application/src/pages/ubicacion_page.dart';
import 'package:repose_application/src/routes/routes.dart';
import 'package:repose_application/src/widgets/geolocalizacion_widget.dart';

import 'package:repose_application/src/widgets/sugerencia_list_widget.dart';

class SitiosCard extends StatelessWidget {
  const SitiosCard({Key? key, required this.model}) : super(key: key);
  final Sitios model;

  @override
  Widget build(BuildContext context) {
    final url = model.urlImagenSitio;
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
                              model.nombreSitio
                                  .toString(),
                              style: Theme.of(context).textTheme.headline6),
                          content: Text(
                              model.descripcionSitio
                                  .toString(),
                              style: Theme.of(context).textTheme.subtitle2),
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextButton(
                                style: ButtonStyle( backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black87)),
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
                                  }),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextButton(
                                style: ButtonStyle( backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black87)),
                                  child: const Text(
                                    'Ubicacion',
                                    textAlign: TextAlign.center,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                         builder: (context) => RequestPermissionPage()
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        )
                      ],
                        );
                    }
                        
                        );
              },
              title: Text(model.nombreSitio.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.white)),
              subtitle: Text(model.ciudadSitio.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.white)),
              trailing: Text("Costo: " + model.costoSitio.toString() + " \$",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.white))),
        ),
      ),
    );
  }
}
