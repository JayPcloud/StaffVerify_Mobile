import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:staff_verify/utils/constants/texts.dart';

class VCloudStorage {

  final cloudinary = CloudinaryPublic(
      VTexts.cloudinaryCloudName, VTexts.cloudinaryPresetName, );

  Future<CloudinaryResponse?> uploadImage(
      {required File imageFile, required String subfolderName}) async {
    try {
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(imageFile.path,
            folder: subfolderName,
            resourceType: CloudinaryResourceType.Image),
      );
      return response;
    } on CloudinaryException catch (e) {
      print(e.message);
      print(e.request);
      return null;
    }
  }

}