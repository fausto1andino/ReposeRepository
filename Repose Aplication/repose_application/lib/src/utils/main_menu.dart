import 'package:flutter/material.dart';
import 'package:repose_application/src/widgets/info_widget.dart';
import 'package:repose_application/src/widgets/pagina_widget.dart';
import 'package:repose_application/src/widgets/sitios_widget.dart';

class MenuItem {
  String label;
  IconData icon;

  MenuItem(this.label, this.icon);
}

List<MenuItem> menuOption = [
  MenuItem("Pagina Principal", Icons.home_work),
  MenuItem("Sitios", Icons.travel_explore),
  MenuItem("Mas Informacion", Icons.info_outline_rounded),
];

List<Widget> contentWidgets = [
  const PaginaPrincipalWidget(),
  const SitiosTuristicosWidget(),
  const SitioInfoWidget()
];
