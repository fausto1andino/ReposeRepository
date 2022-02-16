import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
  late final latitud  = widget.model.lat;
  late final longitud  = widget.model.long;

  @override
  void initState() {
    super.initState();
    Sitios _sitios;
    _sitios = widget.model;
  
  }
  late final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(latitud  as double, longitud as double),
    zoom: 14.4746,
  );
     late final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(latitud as double,  longitud as double),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
      
  @override
  Widget build(BuildContext context) {
    
   
          
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        myLocationEnabled:true,
        myLocationButtonEnabled:true,
        
        markers: const <Marker>{
          
        },

        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
         padding: EdgeInsets.only(top: 650.0,),
      ),
      floatingActionButton: 
      
      Padding(
        padding: const EdgeInsets.only(right: 100.0),
        child: FloatingActionButton.extended(
          onPressed: _goToTheLake,
          label: const Text('Lugar Turistico'),
          icon: const Icon(Icons.directions_boat),
       
        ),
        
      ),
      
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
    
  }
}