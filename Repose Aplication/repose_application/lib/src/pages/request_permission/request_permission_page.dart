import 'dart:async';


import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:repose_application/src/models/sitios_model.dart';
import 'package:repose_application/src/pages/request_permission/request_permission_controller.dart';
import 'package:repose_application/src/routes/routes.dart';
import 'package:repose_application/src/widgets/geolocalizacion_widget.dart';

class RequestPermissionPage extends StatefulWidget {
  RequestPermissionPage({Key? key, required this.model}) : super(key: key);
final Sitios model;
  @override
  State<RequestPermissionPage> createState() => _RequestPermissionPageState();
}

class _RequestPermissionPageState extends State<RequestPermissionPage> {
  final _controller = RequestPermissionController(Permission.locationWhenInUse);
  late StreamSubscription _subscription;
  
  @override
  void initState() {
    super.initState();
    _subscription = _controller.onStatusChanged.listen(
      (status) {
        if (status == PermissionStatus.granted) {
          Navigator.pushReplacementNamed(context, Routes.HOME);
        }
      },
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool? _succes = true;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          child: ElevatedButton(
            child: const Text("Permitir"),
            onPressed: () {
              _controller.request();

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GeolocalizacionWidget(model: widget.model ,)));
            },
          ),
        ),
      ),
    );
  }
}
