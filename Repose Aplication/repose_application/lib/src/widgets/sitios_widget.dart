import 'package:flutter/material.dart';
import 'package:repose_application/src/models/fields_model.dart';

import 'package:repose_application/src/services/sitiosturiticos_services.dart';
import 'package:repose_application/src/widgets/sitios_card.dart';

class SitiosTuristicosWidget extends StatefulWidget {
   SitiosTuristicosWidget({Key? key}) : super(key: key);

  @override
  _SitiosTuristicosWidgetState createState() => _SitiosTuristicosWidgetState();
}

class _SitiosTuristicosWidgetState extends State<SitiosTuristicosWidget> {

  final SitiosTuristicosAPP _sitiosserviceapp = SitiosTuristicosAPP();
  List<FieldsProto>? _listofsitios;




  @override
  void initState() {
    super.initState();
    _downloadrutas();
  }
  @override
  Widget build(BuildContext context) {
    return _listofsitios == null
        ? const Center(
            child: SizedBox(
                height: 50.0, width: 50.0, child: CircularProgressIndicator()))
        : _listofsitios!.isEmpty
            ? const Center(
                child: SizedBox(
                    child: Text("No Hay Datos en Firebase")))
            : Container(
                margin: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 14.0),
                
                    child: ListView(
                  children:  _listofsitios!.map((e) => SitiosCard(model: e)).toList()));
  }

  _downloadrutas() async {
    _listofsitios = await _sitiosserviceapp.getSitios();
    setState(() {});
  }
}