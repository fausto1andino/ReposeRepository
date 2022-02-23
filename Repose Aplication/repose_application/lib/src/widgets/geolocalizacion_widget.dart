// ignore_for_file: unused_local_variable

import 'dart:async';

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

    Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
    Sitios _sitios;
    _sitios = widget.model;
    getCurrentPosition();
    getDirections();
  }

  late final LatLng endLocation = LatLng(latitud as double, longitud as double);
  late final latitud = widget.model.lat;
  late final longitud = widget.model.long;
  late final nombresitios = widget.model.nombreSitio;
  late final descripcionsitios = widget.model.descripcionSitio;


  //GoogleMapController? mapController; //contrller for Google map
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

  late final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(latitud as double,  longitud as double),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Position>(
        future: getCurrentPosition(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: Text('Cargando'));
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
                target: endLocation,
                zoom: 16.0,
              ),
              markers: <Marker>{startLocationes!, endLocationes!},
              polylines: Set<Polyline>.of(polylines.values),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              mapType: MapType.normal,
              
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },


            ),
            floatingActionButton: 
            Padding(
              padding: const EdgeInsets.only(right: 100.0, bottom: 100.0),
              child: FloatingActionButton.extended(
                onPressed: _goToTheLake,
                label: const Text('Lugar Turistico'),
                icon: const Icon(Icons.directions_car),
              ),
        
        
            ),
          );
        }
   

    );
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.deepPurpleAccent,
      points: polylineCoordinates,
        width: 8,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  Future<Position> getCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }

getDirections() async {
      List<LatLng> polylineCoordinates = [];
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          googleAPiKey,
          PointLatLng(position.latitude, position.longitude),
          PointLatLng(endLocation.latitude, endLocation.longitude),
          travelMode: TravelMode.driving,
      );

      if (result.points.isNotEmpty) {
            result.points.forEach((PointLatLng point) {
                polylineCoordinates.add(LatLng(point.latitude, point.longitude));
            });
      } else {
         print(result.errorMessage);
      }
      addPolyLine(polylineCoordinates);
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
    
  }


}

