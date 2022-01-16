// ignore_for_file: non_constant_identifier_names, prefer_const_constructors_in_immutables, prefer_const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:repose_application/src/pages/home_page.dart';
import 'package:repose_application/src/services/Image_service.dart';



class RegistroUsuario extends StatefulWidget {
  RegistroUsuario({Key? key}) : super(key: key);
  
  @override
  _RegistroUsuarioState createState() => _RegistroUsuarioState();
}

class _RegistroUsuarioState extends State<RegistroUsuario> {
  int currentStep = 0;
  File? image;
  String? urlImagen;
  final email_usr = TextEditingController();
  final password_usr = TextEditingController();

  final nombreusr = TextEditingController();
  final Edad = TextEditingController();
  final direccion = TextEditingController();
  final urlImagendoc = TextEditingController();

  final FotosService _fotosService = FotosService();
 
  final List<GlobalKey<FormState>> _listKeys = [
    GlobalKey(),
    GlobalKey(),
  ];

  List<Step> obtnerPasos() => [
        Step(
            isActive: currentStep >= 0,
            title: const Icon(Icons.person),
            content: Form(
                key: _listKeys[0],
                autovalidateMode: AutovalidateMode.always,
                child: user())),
        Step(
            isActive: currentStep >= 1,
            title: const Icon(Icons.image_aspect_ratio_sharp),
            content: Form(
                key: _listKeys[1],
                autovalidateMode: AutovalidateMode.always,
                child: imageuserdatos())),
      ];

  Future _selectImage(ImageSource source) async {
    try {
      final imageCamera =
          await ImagePicker().pickImage(source: source);
      if (imageCamera == null) return;
      final imageTemporary = File(imageCamera.path);
      image = imageTemporary;
       if (image != null) {
      urlImagen = await _fotosService.uploadImage(image!);
    }
    } on Exception {
     // print('Fallo al escoger una imagen: $e');
    }
    setState(() {});
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stepper(
          type: StepperType.horizontal,
          steps: obtnerPasos(),
          currentStep: currentStep,
          onStepContinue: () async {
            final isLastStep = currentStep == obtnerPasos().length - 1;
             print("El valor de step es: "+currentStep.toString());
            if (_listKeys[currentStep].currentState!.validate()) {
              if (isLastStep) {
                await _sendToServer();
               
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          'Registro Completado',
                          textAlign: TextAlign.center,
                        ),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: [
                              Text(
                                'Exitoso',
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                              child: Text(
                                'Aceptar',
                                textAlign: TextAlign.center,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()),
                                );
                              })
                        ],
                      );
                    });
              } else {
                setState(() => currentStep += 1);
              }
            }
          },
          onStepCancel: currentStep == 0
              ? () {
                 Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()),
                                );
                }
              : () {
                  setState(() => currentStep -= 1);
                },
        ));
  }

  Widget user() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 15,
      child: Padding(
        padding: EdgeInsets.all(11),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: email_usr,
              decoration: InputDecoration(
                  labelText: "Email", prefixIcon: Icon(Icons.person_add)),
              validator: emailValidation,
            ),
            TextFormField(
              controller: password_usr,
              decoration: InputDecoration(
                  labelText: "Contraseña",
                  prefixIcon: Icon(Icons.person_add)),
              validator: passwordValidation,
            ),
          ],
        ),
      ),
    );
  }

  Widget imageuserdatos() {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 15,
        child: Padding(
            padding: EdgeInsets.all(11),
            child: Column(
              children: <Widget>[
                TextFormField(
              controller: nombreusr,
              decoration: InputDecoration(
                  labelText: "Cedula o Pasaporte", prefixIcon: Icon(Icons.person_add)),
              validator: nameValidation,
              ),
              TextFormField(
              controller: Edad,
              decoration: InputDecoration(
                  labelText: "Edad", prefixIcon: Icon(Icons.person_add)),
              validator: ageValidation,
            ),
            TextFormField(
              controller: direccion,
              decoration: InputDecoration(
                  labelText: "Direccion", prefixIcon: Icon(Icons.person_add)),
              validator: nameValidation,
            ),
            
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 70),
              title: Text("Escoja su Foto de Perfil"),
              
            ),
              Column(
                  children: [
                    SizedBox(
                      width: 300,
                      height: 150,
                      child: Column(
                        children: [
                          ImagenBotonones(
                                title: "Galeria",
                                icon: Icons.image_aspect_ratio,
                                onClicked: () => _selectImage(ImageSource.gallery)),
                           ImagenBotonones(
                                title: "Camara",
                                icon: Icons.camera_alt,
                                onClicked: () => _selectImage(ImageSource.camera)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )));
  }

  Widget ImagenBotonones({
    required String title,
    required IconData icon,
    required VoidCallback onClicked,
  }) =>
      ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: Size.fromHeight(56),
            primary: Colors.white,
            onPrimary: Colors.black,
            textStyle: TextStyle(fontSize: 20)),
        child: Row(
          children: [
            Icon(icon, size: 28),
            const SizedBox(width: 16),
            Text(title)
          ],
        ),
        onPressed: onClicked,
      );

String? nameValidation(String? usernameUsr) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if(usernameUsr!.isEmpty){
      return "Ingrese alguna letra para continuar";
    }
    else if (!regExp.hasMatch(usernameUsr)) {
      return 'Por favor solo ingrese letras';
    }
    return null;
  }

String? emailValidation(String? emailUsr) {
    String patttern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(patttern);
    if (emailUsr!.isEmpty) {
      return "Email es Requerido para continuar";
    } else if (!regExp.hasMatch(emailUsr)) {
      return "Email necesita un @ y un dominio";
    }
    return null;
  }

String? passwordValidation(String? passwordUsr) {
    if (passwordUsr!.length < 3) {
      return "Mínimo 3 carácteres para el módelo";
    }
    return null;
  }

String? idValidation(String? cedula) {
    //comprobado
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (cedula!.isEmpty) {
      return "Cédula Requerida para continuar";
    } else if (!regExp.hasMatch(cedula)) {
      return "Cédula requiere caracteres numéricos";
    } else if (cedula.length != 10) {
      return "Cédula requiere 10 caracteres";
    }
    return null;
  }
 
String? ageValidation(String? age) {
    String patttern = r'(^[0-9]*$)'; //comprobar si funciona
    RegExp regExp = new RegExp(patttern);
    if (!regExp.hasMatch(age!)) {
      return "Edad requiere caracteres numéricos para continuar";
    } else if (age.isNotEmpty && age.length <= 3) {
      return null;
    } else {
      return "Edad no validad";
    }
  }
  
  Future<void> _sendToServer() async {
    FirebaseFirestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference reference =
          FirebaseFirestore.instance.collection('usuarios');
      await reference.add({
        "email_usr": email_usr.text,
        "password_usr": password_usr.text
      });
    });
    CollectionReference referenceC =
      FirebaseFirestore.instance.collection("creedenciales");
      
    await referenceC.add({
      "nombreusr" : nombreusr.text,
      "Edad" : Edad.text,
      "direccion" : direccion.text,
      "urlImagen_doc" : urlImagen
    });
    
 
  }

 

}
