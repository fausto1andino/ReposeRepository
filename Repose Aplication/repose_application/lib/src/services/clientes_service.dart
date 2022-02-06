import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

import 'package:repose_application/src/models/cliente_model.dart';

class ClienteService {
  final String _urlRoot = "https://reposeturismapp.web.app/api/registro";
  final String _firebaseAPIKey = 'AIzaSyAA4aBX-fmE6jKMkc1azx62IKNCYltD4j8';
  
  Future<Map<String, dynamic>> login(Cliente cliente) async {
    final authData = {
      'email': cliente.email,
      'password': cliente.password,
      'returnSecureToken': true
    };
  final queryParams = {"key": _firebaseAPIKey};

   var uri = Uri.https("www.googleapis.com",
        "/identitytoolkit/v3/relyingparty/verifyPassword", queryParams);

  final resp = await http.post(uri, body: json.encode(authData));

   Map<String, dynamic> decodedResp = json.decode(resp.body);
    developer.log(decodedResp.toString());
    return decodedResp;
  }

   Future<int> postCliente(Cliente cliente) async {
    try {
      var uri = Uri.parse(_urlRoot);
      String clienteBody = clienteToJson(cliente);
      final Map<String, String> _headers = {"content-type": "application/json"};
      var response = await http.post(uri, headers: _headers, body: clienteBody);
      if (response.body.isEmpty) return 400;
      Map<String, dynamic> content = json.decode(response.body);
      int result = content["estado"];
      developer.log("Estado $result");
      return result;
    } catch (ex) {
      developer.log("Error $ex");
      return 500;
    }
  }
}