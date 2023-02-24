import 'package:bachelor_heaven/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class PostAddController extends GetxController {
  File? addImage;

  pickAddImage(ImageSource src) async {
    XFile? xfile = await ImagePicker().pickImage(source: src);
    if (xfile != null) {
      addImage = File(xfile.path);
      update();
    }
  }

  Future<void> pickCamOrGallery(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            children: [
              SimpleDialogOption(
                onPressed: () {
                  pickAddImage(ImageSource.camera);
                  Get.back();
                },
                child: Row(
                  children: [
                    Icon(Icons.camera_alt),
                    horizontalSpace,
                    Text('Camera'),
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  pickAddImage(ImageSource.gallery);
                  Get.back();
                },
                child: Row(
                  children: [
                    Icon(Icons.photo),
                    horizontalSpace,
                    Text('Gallery'),
                  ],
                ),
              )
            ],
          );
        });
  }
}
