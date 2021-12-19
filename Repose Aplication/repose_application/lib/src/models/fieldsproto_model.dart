import 'dart:convert';


import 'package:repose_application/src/models/fields_model.dart';


String fieldsProtoToJson(List<FieldsProto> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FieldsProtoClass{
    FieldsProtoClass({
        this.ciudadSitio,
        this.nombreSitio,
        this.urlImagenSitio,
        this.descripcionSitio,
        this.costoSitio,
        this.direccionSitio,
    });

    Sitio? ciudadSitio;
    Sitio? nombreSitio;
    Sitio? urlImagenSitio;
    Sitio? descripcionSitio;
    CostoSitio? costoSitio;
    Sitio? direccionSitio;

    factory FieldsProtoClass.fromJson(Map<String, dynamic> json) => FieldsProtoClass(
        ciudadSitio: Sitio.fromJson(json["ciudad_sitio"]),
        nombreSitio: Sitio.fromJson(json["nombre_sitio"]),
        urlImagenSitio: Sitio.fromJson(json["urlImagen_sitio"]),
        descripcionSitio: Sitio.fromJson(json["descripcion_sitio"]),
        costoSitio: CostoSitio.fromJson(json["costo_sitio"]),
        direccionSitio: Sitio.fromJson(json["direccion_sitio"])
    );

    Map<String, dynamic> toJson() => {
        "ciudad_sitio": ciudadSitio!.toJson(),
        "nombre_sitio": nombreSitio!.toJson(),
        "urlImagen_sitio": urlImagenSitio!.toJson(),
        "descripcion_sitio": descripcionSitio!.toJson(),
        "costo_sitio": costoSitio!.toJson(),
        "direccion_sitio": direccionSitio!.toJson(),
    };
}


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
