// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

import 'package:repose_application/src/pages/sing_up_page.dart';

String clienteToJson(Cliente data) => json.encode(data.toJson());

class Cliente {
  Cliente({this.displayName, this.email, this.password, this.group, this.role, this.uid, this.urlimagen});

  String? displayName;
  String? email;
  String? password;
  String? group;
  String? role;
  String? uid;
  String? urlimagen;

  Map<String, dynamic> toJson() => {
        "displayName": displayName,
        "email": email,
        "password": password,
        "group": group,
        "role": role,
        "uid": uid,
        "urlimage": urlimagen
      };
  factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
        displayName: json["displayName"],
        email: json["email"],
        password: json["password"],
        group: json["group"],
        role: json["role"],
        uid: json["uid"],
        urlimagen: json["urlimage"]
    );
}