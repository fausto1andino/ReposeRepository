import 'dart:convert';

import 'package:repose_application/src/models/fieldsproto_model.dart';

List<FieldsProto> fieldsProtoFromJson(String str) => List<FieldsProto>.from(
    json.decode(str).map((x) => FieldsProto.fromJson(x)));

class FieldsProto {
  FieldsProto({
    this.fieldsProto,
  });

  FieldsProtoClass? fieldsProto;

  factory FieldsProto.fromJson(Map<String, dynamic> json) => FieldsProto(
        fieldsProto: FieldsProtoClass.fromJson(json["_fieldsProto"]),
      );

  Map<String, dynamic> toJson() => {
        "_fieldsProto": fieldsProto!.toJson(),
      };
}
