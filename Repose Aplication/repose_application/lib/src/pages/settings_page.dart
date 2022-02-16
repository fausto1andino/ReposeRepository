import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:repose_application/src/models/cliente_model.dart';
import 'package:repose_application/src/pages/login_page.dart';
import 'package:repose_application/src/providers/main_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key, required this.currentCliente}) : super(key: key);
  final CollectionReference currentCliente;
  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    return SafeArea(
      
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColorLight,
        appBar: AppBar(title:  Text("Ajustes",
        textAlign: TextAlign.center,
        ),
        
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColorDark,
        ),
        body: StreamBuilder(
            stream:
                widget.currentCliente.where("uid", isEqualTo: userId).snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: Text('Cargando'));
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: snapshot.data!.docs.map((cliente) {
                  var cls =
                      Cliente.fromJson(cliente.data() as Map<String, dynamic>);
                  return Flexible(
                    
                    child: ListView(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(

                          child: ListTile(

                              title: Text("Foto de perfil",
                              textAlign: TextAlign.center,
                              ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 170,
                        width: 170,
                        child: Container(
                             decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
              image: DecorationImage(
                
                  image: NetworkImage(cls.urlimagen.toString()), fit: BoxFit.fitHeight)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                            child: ListTile(
                                trailing: IconButton(
                                    onPressed: () async {
                                      await _auth.signOut();
                                      await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginPage()));
                                    },
                                    icon: const Icon(Icons.logout)),
                                leading: const Icon(Icons.person),
                                title: Text(cls.displayName!),
                                subtitle: const Text("Nombre"))),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                            child: ListTile(
                                leading: const Icon(Icons.computer),
                                title: Text(cls.role!.toString().toUpperCase()),
                                subtitle: const Text("Rol"))),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                            child: ListTile(
                                leading: const Icon(Icons.important_devices),
                                title: Text(cls.uid!.toString()),
                                subtitle: const Text("Id"))),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                            child: ListTile(
                                leading: const Icon(Icons.email),
                                title: Text(cls.email!.toString()),
                                subtitle: const Text("Correo electrónico"))),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                            child: ListTile(
                                leading: const Icon(Icons.people),
                                title: Text("Estado " + cls.group!.toString()),
                                subtitle: const Text("Tipo de Usuario"))),
                      ),
                      const SettingMode()
                    ]),
                  );
                }).toList(),
              );
            }),
      ),
    );
  }
}

class SettingMode extends StatelessWidget {
  const SettingMode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    return Card(
      child: ListTile(
        leading: const Icon(Icons.light_mode),
        title: const Text("Modo claro"),
        subtitle: const Text("Habilitar / deshabilitar el modo claro"),
        trailing: Switch(
            value: mainProvider.mode,
            onChanged: (bool value) async {
              mainProvider.mode = value;
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool("mode", value);
            }),
      ),
    );
  }

  
}
