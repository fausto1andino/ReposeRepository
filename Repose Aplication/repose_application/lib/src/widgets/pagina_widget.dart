import 'package:flutter/material.dart';

class PaginaPrincipalWidget extends StatelessWidget {
const PaginaPrincipalWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.home_filled, size: 35.0),
        Text("Pagina Principal", style: Theme.of(context).textTheme.headline2)
      ],
    ));
  }
}