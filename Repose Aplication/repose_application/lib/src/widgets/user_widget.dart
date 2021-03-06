import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListUsers extends StatefulWidget {
  const ListUsers({Key? key, required this.currentUser}) : super(key: key);

  final CollectionReference currentUser;
  @override
  _ListUsersState createState() => _ListUsersState();
}

class _ListUsersState extends State<ListUsers> {
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
          appBar:
              AppBar(centerTitle: true, title: const Text("Lista de Usuarios")),
          body: SingleChildScrollView(
            child: StreamBuilder(
              stream: widget.currentUser.orderBy('nombreusr').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: Text('Recargando'));
                }
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                    child: Column(
                  children: snapshot.data!.docs.map((creedenciales) {
                    return Card(
                      child: Container(
                        decoration: BoxDecoration(
                         shape: BoxShape.circle,
                        border: Border.all(),
                            image: DecorationImage(
                                image: NetworkImage(
                                    creedenciales['urlImagen_doc'].toString()),
                                fit: BoxFit.contain)),
                        child: ListTile(
                            title: Text(
                          creedenciales['Edad'],
                          style: const TextStyle(
                            fontSize: 22.0,
                          ),
                        ),
                        subtitle: Text(creedenciales['direccion']),
                        trailing: Text(creedenciales['nombreusr']),
                        ),
                      ),
                    );
                  }).toList(),
                    ),
                  ),
                );
              },
            ),
          )),
    );
  }

}
