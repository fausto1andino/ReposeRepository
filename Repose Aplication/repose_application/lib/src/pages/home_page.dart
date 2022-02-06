import 'dart:async';
import 'dart:developer' as developer;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repose_application/src/providers/main_provider.dart';
import 'package:repose_application/src/utils/main_menu.dart';
import 'package:repose_application/src/widgets/tablero_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

 final List<String> _options = [
    " Pagina Inicial ",
    " Sitios ",
    " Registro "
  ];
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
    final mainProvider = Provider.of<MainProvider>(context, listen: true);
    return Scaffold(
      drawer: Drawer(
          child: ListView(
        children: [
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, "/settings");
            },
            leading: const Icon(Icons.settings),
            title: const Text("Ajustes"),
          )
        ],
      )),
      appBar: AppBar(centerTitle: true, title: Text(_options[_selectedIndex]), leading: SizedBox.square(
        dimension: 25.0,
              child: Switch(
                  value: mainProvider.mode,
                  onChanged: (bool value) async {
                    mainProvider.mode = value;
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setBool("mode", value);
                  }
      ))),
       body: _connectionStatus == ConnectivityResult.none
          ? TableroWidget(
              titulo: MenuItem("No hay internet", Icons.cloud_off),
              descripcion: "Verifique la conexión")
          : PageStorage(bucket: _bucket, child: contentWidgets[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (int index) {
            _selectedIndex = index;
            setState(() {});
          },
          type: BottomNavigationBarType.fixed,
          items: menuOption
              .map((e) =>
                  BottomNavigationBarItem(label: e.label, icon: Icon(e.icon)))
              .toList(),
          currentIndex: _selectedIndex),
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
