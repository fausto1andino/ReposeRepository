import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:repose_application/src/widgets/info_widget.dart';
import 'package:repose_application/src/widgets/pagina_widget.dart';
import 'package:repose_application/src/widgets/sitios_widget.dart';

class MenuItem{
  String label;
  IconData icon;

  MenuItem(this.label, this.icon);

}

List<MenuItem> menuOption = [
  MenuItem("Pagina Principal", Icons.first_page),
  MenuItem("Sitios", Icons.travel_explore),
  MenuItem("Mas Informacion de los Sitios", Icons.info_outline_rounded),

];

List<Widget> contentWidgets = [
  const PaginaPrincipalWidget(),
  SitiosTuristicosWidget(),
  SitioInfoWidget()
];