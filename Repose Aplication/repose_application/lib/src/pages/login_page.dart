
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';


import 'package:repose_application/src/bloc/login_bloc.dart';
import 'package:repose_application/src/pages/home_page.dart';
import 'package:repose_application/src/providers/main_provider.dart';
import 'package:repose_application/src/services/clientes_service.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
// ignore: unused_element
late bool _succes = false;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  User? user;

  late LoginBloc bloc;
  ClienteService clienteService = ClienteService();
  bool _obscureText = true;
  bool _succes = false;
  @override
  void initState() {
    bloc = LoginBloc();
    _auth.userChanges().listen(
          (event) => setState(() => user = event),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
            body: Stack(children: [
      Container(
        color: Theme.of(context).primaryColorLight,
        height: size.height * 1,
      ),
      SingleChildScrollView(
          child: Center(
              child: SizedBox(
                  width: size.width * .75,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SafeArea(child: Container(height: 120.h)),
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: Text("Iniciar sesión",
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor)),
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 4.0, vertical: 14.0),
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          width: size.width * .80,
                          decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                  width: 2.0,
                                  color: Theme.of(context).primaryColorDark)),
                          child: Column(
                            children: [
                              StreamBuilder(
                                  stream: bloc.emailStream,
                                  builder: (BuildContext context,
                                          AsyncSnapshot snapshot) =>
                                      TextField(
                                          controller: _emailController,
                                          onChanged: bloc.changeEmail,
                                          decoration: InputDecoration(
                                              errorText:
                                                  snapshot.error?.toString(),
                                              icon: const Icon(Icons.email),
                                              hintText: 'usuario@repose.com',
                                              labelText:
                                                  'Correo electrónico'))),
                              StreamBuilder(
                                  stream: bloc.passwordStream,
                                  builder: (BuildContext context,
                                          AsyncSnapshot snapshot) =>
                                      TextField(
                                          controller: _passwordController,
                                          onChanged: bloc.changePassword,
                                          obscureText: _obscureText,
                                          decoration: InputDecoration(
                                            suffixIcon: IconButton(
                                                onPressed: () {
                                                  _obscureText = !_obscureText;
                                                  setState(() {});
                                                },
                                                icon: _obscureText
                                                    ? const Icon(
                                                        Icons.visibility)
                                                    : const Icon(
                                                        Icons.visibility_off)),
                                            errorText:
                                                snapshot.error?.toString(),
                                            icon:
                                                const Icon(Icons.lock_outline),
                                            labelText: 'Contraseña',
                                          ))),
                              StreamBuilder(
                                  stream: bloc.loginValidStream,
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20.0),
                                      child: ElevatedButton.icon(
                                          onPressed: () async {
                                            await _login();
                                            if (_succes) {
                                              await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const HomePage()));
                                              setState(() {});
                                            }
                                          },
                                          icon: const Icon(Icons.login),
                                          label: const Text("Ingresar")),
                                    );
                                  })
                            ],
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text("¿No tiene una cuenta?"),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, "/singUp");
                              },
                              child: const Text("Registrarse")),
                        ],
                      )
                    ],
                  )))),
    ])));
  }

  Future<void> _login() async {
     final mainProvider = Provider.of<MainProvider>(context, listen: false);
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ))
          .user!;

      if (user.uid.isNotEmpty)  {
        setState(() {
           mainProvider.token =  user.uid;
          _succes = true;
        });
      } else {
        _succes = false;
      }
    } catch (e) {
      ScaffoldSnackbar.of(context)
          .show('Error al iniciar: sesión con correo electrónico y contraseña');
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
