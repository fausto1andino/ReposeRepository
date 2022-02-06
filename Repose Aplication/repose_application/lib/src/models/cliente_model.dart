// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

String clienteToJson(Cliente data) => json.encode(data.toJson());

class Cliente {
  Cliente({this.displayName, this.email, this.password, this.group, this.role, this.uid});

  String? displayName;
  String? email;
  String? password;
  String? group;
  String? role;
  String? uid;

  Map<String, dynamic> toJson() => {
        "displayName": displayName,
        "email": email,
        "password": password,
        "group": group,
        "role": role,
        "uid": uid
      };
  factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
        displayName: json["displayName"],
        email: json["email"],
        password: json["password"],
        group: json["group"],
        role: json["role"],
        uid: json["uid"],
    );
}