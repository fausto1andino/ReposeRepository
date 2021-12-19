import 'dart:convert';


import 'package:repose_application/src/models/costositio_model.dart';
import 'package:repose_application/src/models/fields_model.dart';
import 'package:repose_application/src/models/sitio_model.dart';
import 'package:repose_application/src/models/sitio_model.dart';


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






