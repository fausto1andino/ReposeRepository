import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:repose_application/src/pages/settings_page.dart';
import 'package:repose_application/src/widgets/user_widget.dart';

class PaginaPrincipalWidget extends StatelessWidget {
  const PaginaPrincipalWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference creedenciales =
        FirebaseFirestore.instance.collection('creedenciales');
   CollectionReference cliente = 
        FirebaseFirestore.instance.collection('cliente');

    return Container(
      alignment: Alignment.center,
      child: SizedBox(
          height: 300,
          child: SingleChildScrollView(
            child: Card(
              elevation: 25.0,
              child: Column(
                children: [
                  SizedBox(
                     height: 200,
                    child: Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://cdn.discordapp.com/attachments/831222223988719726/910216755979374632/unknown.png"),
                              fit: BoxFit.fill)),
                      child: const ListTile(),
                    ),
                  ),
                  MaterialButton(
                    child:  Text("Lista de Usuarios",
                      style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Colors.white)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ListUsers(currentUser: creedenciales)));
                    },
                    color: Colors.orange[700],
                  ),
                   MaterialButton(
                    child:  Text("Configuracion",
                      style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Colors.white)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SettingPage(currentCliente: cliente)));
                    },
                    color: Colors.orange[700],
                  )
                ],
              ),
            ),
          )),
    );
  }

}
