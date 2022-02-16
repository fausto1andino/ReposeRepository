import 'dart:async';
import 'dart:developer' as developer;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';

import 'package:repose_application/src/utils/main_menu.dart';
import 'package:repose_application/src/widgets/tablero_widget.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final PageStorageBucket _bucket = PageStorageBucket();
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
     initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      drawer: Drawer(
          child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
               decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).hintColor,
                                  width: 1.0),
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(25.0),
                            ),
              child: ListTile(
                onTap: () {
                  Navigator.pushNamed(context, "/settings");
                },
                leading: const Icon(Icons.settings),
                title: const Text("Ajustes"),
              ),
            ),
          )
        ],
      )),
      appBar: AppBar(centerTitle: true, title: Text("Sitios Turísticos"), leading: SizedBox.square(
        dimension: 25.0,
             )),
       body: _connectionStatus == ConnectivityResult.none
          ? TableroWidget(
              titulo: MenuItem("No hay internet", Icons.cloud_off),
              descripcion: "Verifique la conexión")
          : PageStorage(bucket: _bucket, child: contentWidgets[_selectedIndex]),
     
    );
  }
  
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
   
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }
}
