import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../components/dialogs.dart';

class VImagePickerController extends GetxController{

  VImagePickerController._();

  static VImagePickerController instance = VImagePickerController._();

  final _imagePicker = ImagePicker();

  Rx<XFile?> pickedImage = Rx(null);

  Future<void> _selectImage(ImageSource source) async {
    try{
      Get.back();
      if(pickedImage.value != null) {
        pickedImage.value = null;
      }
      final XFile? image = await _imagePicker.pickImage(source: source);
      if(image != null) {
        final croppedImage = await cropImage(image.path);
        if(croppedImage != null) {
          pickedImage.value = XFile(croppedImage.path);
        }
      }
    } catch (e) {
      print(e);
    }

  }

  Future<CroppedFile?> cropImage(String path) async {
    CroppedFile?  croppedImage = await ImageCropper.platform.cropImage(
      sourcePath: path,

      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image to Fit',
          aspectRatioPresets: [CropAspectRatioPreset.square],
          toolbarColor: Get.context!.theme.colorScheme.primary,
          toolbarWidgetColor: Get.context!.theme.colorScheme.surface,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
          cropStyle: CropStyle.circle
        ),
        IOSUiSettings(
          minimumAspectRatio: 1.0,
          cropStyle: CropStyle.circle,
          aspectRatioPresets: [CropAspectRatioPreset.square],
        )
      ]
    );
   return croppedImage;
  }

  void displayPickImageDialog() {
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return VImageSourceDialog(
            cameraSelect: ()=>_selectImage(ImageSource.camera),
            gallerySelect: ()=>_selectImage(ImageSource.gallery),
          );
        }
    );
  }
}

