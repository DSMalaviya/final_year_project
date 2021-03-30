import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImgPicker {
  File image;
  final picker = ImagePicker();

  Future<File> selctImg() async {
    try {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        image = File(pickedFile.path);
        return image;
      } else {
        return null;
      }
    } catch (e) {
      throw (e);
    }
  }
}
