import 'package:http/http.dart' as http;
import 'package:repose_application/src/models/fields_model.dart';
import 'dart:convert';


class SitiosTuristicosAPP {
  SitiosTuristicosAPP();

  final String  _rootUrl = 'https://repose-backend.web.app/api/sitiosturisticos';

  Future<List<FieldsProto>> getSitios() async {
  List<FieldsProto> resultSitios = [];
  try{
      var url = Uri.parse(_rootUrl);
      final responseList = await http.get(url);

      
      List<dynamic> listSitios = json.decode(responseList.body);
      
        for (var item in listSitios){
        
            final sitios = FieldsProto.fromJson(item);
            resultSitios.add(sitios);
         
        }
  return resultSitios;
  }catch(ex){
    //print (ex);
    return resultSitios;
  }
}
}