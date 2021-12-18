import 'dart:convert';
List<FieldsProto> fieldsProtoFromJson(String str) => List<FieldsProto>.from(json.decode(str).map((x) => FieldsProto.fromJson(x)));

String fieldsProtoToJson(List<FieldsProto> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


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

class FieldsProtoClass {
    FieldsProtoClass({
        this.ciudadSitio,
        this.nombreSitio,
        this.urlImagenSitio,
        this.descripcionSitio,
    });

    Sitio? ciudadSitio;
    Sitio? nombreSitio;
    Sitio? urlImagenSitio;
    Sitio? descripcionSitio;

    factory FieldsProtoClass.fromJson(Map<String, dynamic> json) => FieldsProtoClass(
        ciudadSitio: Sitio.fromJson(json["ciudad_sitio"]),
        nombreSitio: Sitio.fromJson(json["nombre_sitio"]),
        urlImagenSitio: Sitio.fromJson(json["urlImagen_sitio"]),
        descripcionSitio: Sitio.fromJson(json["descripcion_sitio"]),
    );

    Map<String, dynamic> toJson() => {
        "ciudad_sitio": ciudadSitio!.toJson(),
        "nombre_sitio": nombreSitio!.toJson(),
        "urlImagen_sitio": urlImagenSitio!.toJson(),
        "descripcion_sitio": descripcionSitio!.toJson(),
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
