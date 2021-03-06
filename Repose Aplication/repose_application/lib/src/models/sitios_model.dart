// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<Sitios> welcomeFromJson(String str) => List<Sitios>.from(json.decode(str).map((x) => Sitios.fromJson(x)));

String welcomeToJson(List<Sitios> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Sitios {
    Sitios({
        this.idsitios,
        this.ciudadSitio,
        this.costoSitio,
        this.descripcionSitio,
        this.nombreSitio,
        this.urlImagenSitio,
        this.lat,
        this.long,
        this.idvid

        
    });

    String? idsitios;
    String? ciudadSitio;
    int? costoSitio;
    String? descripcionSitio;
    String? nombreSitio;
    String? urlImagenSitio;
    double? lat;
    double? long;
    String? idvid;

    factory Sitios.fromJson(Map<String, dynamic> json) => Sitios(
        idsitios: json["idsitios"],
        ciudadSitio: json["ciudad_sitio"],
        costoSitio: json["costo_sitio"],
        descripcionSitio: json["descripcion_sitio"],
        nombreSitio: json["nombre_sitio"],
        urlImagenSitio: json["urlImagen_sitio"],
        lat: json["lat"],
        long: json["long"],
        idvid: json["idvid"]
    );

    Map<String, dynamic> toJson() => {
        "idsitios": idsitios,
        "ciudad_sitio": ciudadSitio,
        "costo_sitio": costoSitio,
        "descripcion_sitio": descripcionSitio,
        "nombre_sitio": nombreSitio,
        "urlImagen_sitio": urlImagenSitio,
        "lat": lat,
        "long": long,
        "idvid": idvid
    };
}
