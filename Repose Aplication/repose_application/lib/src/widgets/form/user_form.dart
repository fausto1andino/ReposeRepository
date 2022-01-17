  import 'package:flutter/material.dart';
import 'package:repose_application/src/utils/validation_util.dart';

Widget user(TextEditingController emailUsr,  TextEditingController passwordUsr,) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 15,
      child: Padding(
        padding: const EdgeInsets.all(11),
        child: Column(
          children: <Widget>[
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: emailUsr,
              decoration: const InputDecoration(
                  labelText: "Email", prefixIcon: Icon(Icons.email)),
              validator: emailValidation,
            ),
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              obscuringCharacter: "*",
              obscureText: true,
              controller: passwordUsr,
              decoration: const InputDecoration(
                  labelText: "Contraseña", prefixIcon: Icon(Icons.password_sharp)),
              validator: passwordValidation,
            ),
          ],
        ),
      ),
    );
  }
