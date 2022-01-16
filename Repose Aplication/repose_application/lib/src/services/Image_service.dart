
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';


class FotosService{
  FotosService();

  Future<String> uploadImage(File image) async {
    final cloudinary = CloudinaryPublic('dsuh0d4g5', 'ml_default', cache: false);
    try {
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(image.path,
            resourceType: CloudinaryResourceType.Image),
      );
      return response.secureUrl;
    } on CloudinaryException catch (e) {
      // ignore: avoid_print
      print(e.message);
      // ignore: avoid_print
      print(e.request);
      return "";
    }
  }
}