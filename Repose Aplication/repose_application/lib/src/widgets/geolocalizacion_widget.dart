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
  
  String? currentLocation;
  double? latitudUser;
  double? longitudUser;

  
  late final latitud  = widget.model.lat;
  late final longitud  = widget.model.long;
  late final nombresitios = widget.model.nombreSitio;
  late final descripcionsitios = widget.model.descripcionSitio;

  GoogleMapController? mapController; //contrller for Google map
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyBOE-SVm9xr0Xq_x8IPl4g0RYkCMhPaNac";
  Map<PolylineId, Polyline> polylines = {}; //polylines to show direction

 

  
  void getCurrentLocation() async {
    LocationPermission permission;
    
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          currentLocation ="Permisos Denegados";
        });
      }else{
        var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        setState(() {
          longitudUser = position.longitude;
          latitudUser = position.longitude;
        });
      }
    }else{
      var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
        longitudUser = position.longitude;
        latitudUser = position.longitude;
      });
    }
  }
  
  late final Marker? startLocationes = Marker(
          markerId: MarkerId(nombresitios!),
          position: LatLng(latitudUser as double, longitudUser as double),
          infoWindow: InfoWindow(
            title: "Mi ubicacion"
          ),
          );
  
  late final Marker? endLocationes = Marker(
        markerId: MarkerId(nombresitios!),
        position: LatLng(latitud as double, longitud as double),
        infoWindow: InfoWindow(
          title: nombresitios,
          snippet: descripcionsitios,
        ),
        );

  @override
  void initState() {
    super.initState();
    Sitios _sitios;
    _sitios = widget.model;
  
  }
  

  
  late final LatLng startLocation = LatLng(latitudUser as double, longitudUser as double);
  late final LatLng endLocation = LatLng(latitud as double, longitud as double);
  
  

  getDirections() async {
      List<LatLng> polylineCoordinates = [];
     
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          googleAPiKey,
          PointLatLng(startLocation.latitude, startLocation.longitude),
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
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          appBar: AppBar( 
             title: Text("Direccion del Lugar turistico"),
             backgroundColor: Colors.deepPurpleAccent,
          ),
          body: GoogleMap( //Map widget from google_maps_flutter package
                    zoomGesturesEnabled: true, //enable Zoom in, out on map
                    initialCameraPosition: CameraPosition( //innital position in map
                      target: startLocation, //initial position
                      zoom: 16.0, //initial zoom level
                    ),
                    markers:  <Marker>{
                      startLocationes!,
                      endLocationes!}, //markers to show on map
                    polylines: Set<Polyline>.of(polylines.values), 
                    myLocationEnabled:true,
                    myLocationButtonEnabled:true,//polylines
                    mapType: MapType.normal, //map type
                    onMapCreated: (controller) { //method called when map is created
                      setState(() {
                        mapController = controller; 
                      });
                    },
              ),
       );
  }
  


}