// import 'dart:html';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickProvider with ChangeNotifier {
  // File? img;
  File? img;
  Future<void> getPhoto() async {
    final Image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (Image == null) {
      return;
    } else {
      final photoTemp = File(Image.path);

      img = photoTemp;
    }
    notifyListeners();
  }
}
