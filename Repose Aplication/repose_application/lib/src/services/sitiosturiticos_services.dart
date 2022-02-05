import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:repose_application/src/models/sitios_model.dart';

class SitiosTuristicosAPP {
  SitiosTuristicosAPP();

  final String _rootUrl = 'https://reposeturismapp.web.app/api/sitios';

  Future<List<Sitios>> getSitios() async {
    List<Sitios> resultSitios = [];
    try {
      var url = Uri.parse(_rootUrl);
      final responseList = await http.get(url);

      List<dynamic> listSitios = json.decode(responseList.body);

      for (var item in listSitios) {
        final sitios = Sitios.fromJson(item);
        resultSitios.add(sitios);
      }
      return resultSitios;
    } catch (ex) {
      //print (ex);
      return resultSitios;
    }
  }
}
