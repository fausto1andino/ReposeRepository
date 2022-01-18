// ignore_for_file: non_constant_identifier_names, prefer_const_constructors_in_immutables, prefer_const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:repose_application/src/pages/home_page.dart';
import 'package:repose_application/src/services/Image_service.dart';
import 'package:repose_application/src/widgets/form/personal_form.dart';
import 'package:repose_application/src/widgets/form/user_form.dart';

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
            title: const Icon(Icons.person_add),
            content: Form(
                key: _listKeys[0],
                autovalidateMode: AutovalidateMode.always,
                child: user(email_usr, password_usr))),
        Step(
            isActive: currentStep >= 1,
            title: const Icon(Icons.add_a_photo),
            content: Form(
                key: _listKeys[1],
                autovalidateMode: AutovalidateMode.always,
                child:
                    imageuserdatos(Edad, direccion, nombreusr, _selectImage))),
      ];

  Future _selectImage(ImageSource source) async {
   
      final imageCamera = await ImagePicker().pickImage(source: source);
      if (imageCamera == null) return;
      final imageTemporary = File(imageCamera.path);
      image = imageTemporary;
      if (image != null) {
        urlImagen = await _fotosService.uploadImage(image!);
      }
    
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Scaffold(
          body: Stepper(
        physics: ScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        elevation: 10,
        type: StepperType.horizontal,
        steps: obtnerPasos(),
        currentStep: currentStep,
        onStepContinue: () async {
          final isLastStep = currentStep == obtnerPasos().length - 1;
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
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              }
            : () {
                setState(() => currentStep -= 1);
              },
      )),
    );
  }

  Future<void> _sendToServer() async {
    FirebaseFirestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference reference =
          FirebaseFirestore.instance.collection('usuarios');
      await reference.add(
          {"email_usr": email_usr.text, "password_usr": password_usr.text});
    });
    CollectionReference referenceC =
        FirebaseFirestore.instance.collection("creedenciales");

    await referenceC.add({
      "nombreusr": nombreusr.text,
      "Edad": Edad.text,
      "direccion": direccion.text,
      "urlImagen_doc": urlImagen
    });
  }


}
