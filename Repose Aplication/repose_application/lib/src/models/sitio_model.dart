import 'dart:convert';

import 'package:repose_application/src/models/fields_model.dart';

String fieldsProtoToJson(List<FieldsProto> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Sitio {
  Sitio({
    this.stringValue,
    this.valueType,
  });

  String? stringValue;
  String? valueType;

  factory Sitio.fromJson(Map<String, dynamic> json) => Sitio(
        stringValue: json["stringValue"],
        valueType: json["valueType"],
      );

  Map<String, dynamic> toJson() => {
        "stringValue": stringValue,
        "valueType": valueType,
      };
}
