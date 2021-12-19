import 'dart:convert';

import 'package:repose_application/src/models/fields_model.dart';

String fieldsProtoToJson(List<FieldsProto> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CostoSitio {
  CostoSitio({
    this.integerValue,
    this.valueType,
  });

  String? integerValue;
  String? valueType;

  factory CostoSitio.fromJson(Map<String, dynamic> json) => CostoSitio(
        integerValue: json["integerValue"],
        valueType: json["valueType"],
      );

  Map<String, dynamic> toJson() => {
        "integerValue": integerValue,
        "valueType": valueType,
      };
}
