// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:repose_application/src/models/sitios_model.dart';

class GeolocalizacionWidget extends StatefulWidget {
  const GeolocalizacionWidget({Key? key, required this.model})
      : super(key: key);
  final Sitios model;
  @override
  State<GeolocalizacionWidget> createState() => _GeolocalizacionWidgetState();
}

class _GeolocalizacionWidgetState extends State<GeolocalizacionWidget> {
  @override
  void initState() {
    super.initState();
    Sitios _sitios;
    _sitios = widget.model;
    getCurrentPosition();
  }

  late final LatLng endLocation = LatLng(latitud as double, longitud as double);
  late final latitud = widget.model.lat;
  late final longitud = widget.model.long;
  late final nombresitios = widget.model.nombreSitio;
  late final descripcionsitios = widget.model.descripcionSitio;

  GoogleMapController? mapController; //contrller for Google map
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyBOE-SVm9xr0Xq_x8IPl4g0RYkCMhPaNac";
  Map<PolylineId, Polyline> polylines = {}; //polylines to show direction

  late final Marker? endLocationes = Marker(
    markerId: MarkerId(nombresitios!),
    position: LatLng(latitud as double, longitud as double),
    infoWindow: InfoWindow(
      title: nombresitios,
      snippet: descripcionsitios,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Position>(
        future: getCurrentPosition(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: Text('loading'));
          }
          late final LatLng startLocation =
              LatLng(snapshot.data!.latitude, snapshot.data!.longitude);
          late final LatLng endLocation =
              LatLng(latitud as double, longitud as double);
          late final Marker? startLocationes = Marker(
            markerId: MarkerId(nombresitios!),
            position: LatLng(snapshot.data!.latitude, snapshot.data!.longitude),
            infoWindow: InfoWindow(title: "Mi ubicacion"),
          );

          List<LatLng> latlng = [startLocation, endLocation];

          final Set<Polyline> _polyline = {
            Polyline(
              polylineId: PolylineId(nombresitios!),
              visible: true,
              points: latlng,
              color: Colors.blue,
              geodesic: true,
            )
          };
          return Scaffold(
            appBar: AppBar(
              title: Text("Direccion del Lugar turistico"),
              backgroundColor: Colors.deepPurpleAccent,
            ),
            body: GoogleMap(
              zoomGesturesEnabled: true,
              initialCameraPosition: CameraPosition(
                target: startLocation,
                zoom: 16.0,
              ),
              markers: <Marker>{startLocationes!, endLocationes!},
              polylines: _polyline,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              mapType: MapType.normal,
              onMapCreated: (controller) {
                setState(() {
                  mapController = controller;
                });
              },
            ),
          );
        });
  }

  Future<Position> getCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }
}
