import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ImageHelper {
  File? image;

  Future<File?> getFromGallery() async {
    try {
      final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null) return null;
      return File(image.path);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
    return null;
  }
}
