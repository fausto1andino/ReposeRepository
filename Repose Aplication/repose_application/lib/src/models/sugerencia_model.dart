// To parse this JSON data, do
//
//     final material = materialFromJson(jsonString);

import 'dart:convert';

Sugerencia materialFromJson(String str) => Sugerencia.fromJson(json.decode(str));

String materialToJson(Sugerencia data) => json.encode(data.toJson());

class Sugerencia {
  Sugerencia(
      {this.id,
      required this.valoracion,
      required this.titulo,
      required this.comentario});

  int? id;
  int valoracion;
  String titulo;
  String comentario;

  factory Sugerencia.fromJson(Map<String, dynamic> json) => Sugerencia(
      id: json["id"],
      valoracion: json["valoracion"] as int,
      titulo: json["titulo"],
      comentario: json["comentario"]);

  factory Sugerencia.created() => Sugerencia(valoracion: 0, titulo: "", comentario: "");

  Map<String, dynamic> toJson() =>
      {"id": id, "valoracion": valoracion, "titulo": titulo, "comentario": comentario};
}