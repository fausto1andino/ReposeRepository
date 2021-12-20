import 'package:flutter/material.dart';
import 'package:repose_application/src/models/fields_model.dart';

import 'package:repose_application/src/services/sitiosturiticos_services.dart';
import 'package:repose_application/src/widgets/info_card.dart';


class SitioInfoWidget extends StatefulWidget {
  const SitioInfoWidget({Key? key}) : super(key: key);

  @override
  _SitioInfoWidgetState createState() => _SitioInfoWidgetState();
}

class _SitioInfoWidgetState extends State<SitioInfoWidget> {
  final SitiosTuristicosAPP _sitiosinfoserviceapp = SitiosTuristicosAPP();
  List<FieldsProto>? _listofsitiosinfo;

  @override
  void initState() {
    super.initState();
    _downloadrutas();
  }
  @override
  Widget build(BuildContext context) {
    return _listofsitiosinfo == null
        ? const Center(
            child: SizedBox(
                height: 50.0, width: 50.0, child: CircularProgressIndicator()))
        : _listofsitiosinfo!.isEmpty
            ? const Center(
                child: SizedBox(
                    child: Text("Sin Datos")))
            : Container(
                margin: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 14.0),
                
                    child: ListView(
                  children:  _listofsitiosinfo!.map((e) => InfoCard(model: e)).toList()));
  }

  _downloadrutas() async {
    _listofsitiosinfo = await _sitiosinfoserviceapp.getSitios();
    setState(() {});
  }
}