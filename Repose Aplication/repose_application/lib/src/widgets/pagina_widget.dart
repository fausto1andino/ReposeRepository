import 'package:flutter/material.dart';

class PaginaPrincipalWidget extends StatelessWidget {
  const PaginaPrincipalWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SizedBox(
        height: 250,
        child: Card(
          elevation: 25.0,
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage("https://cdn.discordapp.com/attachments/831222223988719726/910216755979374632/unknown.png"), fit: BoxFit.cover)),
            child: const ListTile(),
        ),
      )),
    );
  }
}
