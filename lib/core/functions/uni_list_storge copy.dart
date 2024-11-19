import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

Future<Uint8List?> pickStorage(ImageSource source) async {
  try {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: source);
    if (file != null) {
      Uint8List image = await file.readAsBytes();
      return image;
    }
    print("no image found");
    return null;
  } catch (e) {
    throw Exception(e.toString());
  }
}


pickStorageImage(ImageSource source)async{
  ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if(_file != null){
    return await _file.readAsBytes();
  }
  print("no image found");
}


