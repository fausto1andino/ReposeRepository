import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:repose_application/src/widgets/pagina_widget.dart';
import 'package:repose_application/src/widgets/register_widget.dart';
import 'package:repose_application/src/widgets/sitios_widget.dart';

 CollectionReference creedenciales =
        FirebaseFirestore.instance.collection('creedenciales');  
class MenuItem {
  String label;
  IconData icon;

  MenuItem(this.label, this.icon);
}

List<MenuItem> menuOption = [
  MenuItem("Pagina Principal", Icons.home_work),
  MenuItem("Sitios", Icons.travel_explore),
  MenuItem("Registro", Icons.reviews),
];

List<Widget> contentWidgets = [
 const PaginaPrincipalWidget(),
  const SitiosTuristicosWidget(),
   RegistroUsuario()
];
