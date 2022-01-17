
// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

Widget ImagenBotonones({
    required String title,
    required IconData icon,
    required VoidCallback onClicked,
  }) =>
      ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(56),
            primary: Colors.white,
            onPrimary: Colors.black,
            textStyle: const TextStyle(fontSize: 20)),
        child: Row(
          children: [
            Icon(icon, size: 28),
            const SizedBox(width: 16),
            Text(title)
          ],
        ),
        onPressed: onClicked,
      );
