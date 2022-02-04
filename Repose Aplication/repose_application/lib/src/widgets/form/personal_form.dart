

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:repose_application/src/utils/validation_util.dart';
import 'package:repose_application/src/widgets/buttons/imagen_button.dart';



Widget imageuserdatos(TextEditingController  edad,TextEditingController direccion,TextEditingController nombreusr, Future Function(ImageSource source) _selectImage ) {
   
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 15,
        child: Padding(
            padding: const EdgeInsets.all(11),
            child: Column(
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: nombreusr,
                  decoration: const InputDecoration(
                      labelText: "Nombre del Usuario",
                      prefixIcon: Icon(Icons.person_add)),
                  validator: nameValidation,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: edad,
                  decoration: const InputDecoration(
                      labelText: "Edad", prefixIcon: Icon(Icons.date_range)),
                  validator: ageValidation,
                ),
                TextFormField(
                  keyboardType: TextInputType.streetAddress,
                  controller: direccion,
                  decoration: const InputDecoration(
                      labelText: "Direccion",
                      prefixIcon: Icon(Icons.directions)),
                  validator: nameValidation,
                ),
                const ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 70),
                  title: Text("Escoja su Foto de Perfil"),
                ),
                Column(
                  children: [
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 100,
                                child: ImagenBotonones(
                                    title: "",
                                    icon: Icons.image_search,
                                    onClicked: () =>
                                        _selectImage(ImageSource.gallery)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 100,
                                child: ImagenBotonones(
                                    title: "",
                                    icon: Icons.camera_alt,
                                    onClicked: () =>
                                        _selectImage(ImageSource.camera)),
                              ),
                            ),
                          ],
                        ),
                     ),
                 
                  ],
                ),
                
              ],
            )));
  
  }
