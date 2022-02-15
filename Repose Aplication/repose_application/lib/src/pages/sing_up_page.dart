// ignore_for_file: unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:repose_application/src/bloc/signup_bloc.dart';
import 'package:repose_application/src/models/cliente_model.dart';
import 'package:repose_application/src/pages/login_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:repose_application/src/services/clientes_service.dart';
import 'package:repose_application/src/services/notificationservice.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

late bool? _success;
late String _userEmail = '';

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _obscureText = true;
  late String us = "";
  final email = TextEditingController();
  final password = TextEditingController();
  final displayName = TextEditingController();
  final group = TextEditingController();
  final role = TextEditingController();
  final SignUpBloc _signUpBloc = SignUpBloc();

  final ClienteService _cliServ = ClienteService();

  final NotificationService _ntfc = NotificationService();
 

  final List<String> _roles = ["Administrador", "Usuario", "Centro Turistico"];
  String _roleSelected = "Administrador";

  final List<String> _groups = ["A", "B", "C"];
  String _groupSelected = "A";

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.height;

    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
          child: Stack(children: [
        Container(
          color: Theme.of(context).primaryColorDark,
          height: size * 0.4,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 80.0, left: 35.0, right: 35.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text("Registro de usuario",
                    style: Theme.of(context).textTheme.headline4!.apply(
                        color: Theme.of(context).scaffoldBackgroundColor)),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).hintColor, width: 2.0),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StreamBuilder<String>(
                          stream: _signUpBloc.usernameStream,
                          builder: (context, snapshot) {
                            return TextField(
                                controller: displayName,
                                keyboardType: TextInputType.emailAddress,
                                onChanged: _signUpBloc.changeUsername,
                                decoration: InputDecoration(
                                    errorText: snapshot.error?.toString(),
                                    icon: const Icon(Icons.person),
                                    labelText: "Nombre",
                                    hintText: "Nombre y apellido"));
                          }),
                      StreamBuilder<String>(
                          stream: _signUpBloc.emailStream,
                          builder: (context, snapshot) {
                            return TextField(
                                controller: email,
                                keyboardType: TextInputType.emailAddress,
                                onChanged: _signUpBloc.changeEmail,
                                decoration: InputDecoration(
                                    errorText: snapshot.error?.toString(),
                                    icon: const Icon(Icons.email),
                                    labelText: "Correo electrónico",
                                    hintText: "admin@repose.com"));
                          }),
                      StreamBuilder<String>(
                          stream: _signUpBloc.passwordStream,
                          builder: (context, snapshot) {
                            return TextField(
                                controller: password,
                                onChanged: _signUpBloc.changePassword,
                                obscureText: _obscureText,
                                decoration: InputDecoration(
                                    errorText: snapshot.error?.toString(),
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          _obscureText = !_obscureText;
                                          setState(() {});
                                        },
                                        icon: Icon(
                                          _obscureText
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                        )),
                                    icon: const Icon(Icons.lock),
                                    labelText: "Contraseña"));
                          }),
                      DropdownButton<String>(
                          onChanged: (String? newValue) {
                            _roleSelected = newValue!;

                            setState(() {});
                          },
                          value: _roleSelected,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                          underline: Container(height: 2),
                          items: _roles
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList()),
                      DropdownButton<String>(
                          onChanged: (String? newValue) async {
                            _groupSelected = newValue!;

                            setState(() {});
                          },
                          value: _groupSelected,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                          underline: Container(height: 2),
                          items: _groups
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList()),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: StreamBuilder<bool>(
                            stream: _signUpBloc.formSignUpStream,
                            builder: (context, snapshot) {
                              return ElevatedButton.icon(
                                  onPressed: snapshot.hasData
                                      ? () async {
                                          try {
                                            await _register();
                                            if (_success = true) {
                                              await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const LoginPage())
                                                            
                                                            );
                                                            setState(() {
                                                              
                                                            });
                                            }
                                             Cliente cli = Cliente(
                                                group: _groupSelected,
                                                role: _roleSelected,
                                                displayName:
                                                    _signUpBloc.username,
                                                email: _signUpBloc.email,
                                                password: _signUpBloc.password);
                                            int result =
                                                await _cliServ.postCliente(cli);
                                            if (result == 201) {
                                              Navigator.pop(context);
                                            }
                                          } catch (e) {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        "Error email ya registrado"),
                                                    actions: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          TextButton(
                                                              style: ButtonStyle(
                                                                  backgroundColor:
                                                                      MaterialStateProperty.all<
                                                                              Color>(
                                                                          Colors
                                                                              .black87)),
                                                              child: const Text(
                                                                'Regresar',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                              onPressed: () {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              const SignUpPage()),
                                                                );
                                                              }),
                                                        ],
                                                      )
                                                    ],
                                                  );
                                                });
                                          }
                                        }
                                      : null,
                                  icon: const Icon(Icons.app_registration),
                                  label: const Text("Registrarte"));
                            }),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ])),
    ));
  }

  Future<void> _enviaralServer() async {

    FirebaseFirestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference reference;
      reference = FirebaseFirestore.instance.collection('cliente');
      await reference.add({
        "uid": us,
        "email": email.text,
        "password": password.text,
        "displayName": displayName.text,
        "group": group.text = _groupSelected,
        "role": role.text = _roleSelected,
      });
    });
  }

  Future<void> _register() async {
    final User? user = (await _auth.createUserWithEmailAndPassword(
      email: email.text,
      password: password.text,
    )).user;
    us = user!.uid;
    if (user != null) {
      String? token = await FirebaseMessaging.instance.getToken();
        FirebaseMessaging messaging = FirebaseMessaging.instance;
      await _enviaralServer();
      ScaffoldSnackbar.of(context).show(" El usuario con el email ${email.text} y nombre ${displayName.text} Ha sido resgitrado"  );
    
      setState(() {
        _success = true;
        _userEmail = user.email ?? '';
      });
    } else {
      _success = false;
    }
    
  }
}
class ScaffoldSnackbar {
  ScaffoldSnackbar(this._context);
  final BuildContext _context;

  factory ScaffoldSnackbar.of(BuildContext context) {
    return ScaffoldSnackbar(context);
  }

  void show(String message) {
    ScaffoldMessenger.of(_context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message)),
      );
  }
}
