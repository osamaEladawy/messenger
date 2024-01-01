
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileServise with ChangeNotifier{

  final picker = ImagePicker();
  XFile? _image  ;
  XFile? get image => _image;


  Future pickGalleryImage(BuildContext context)async{
    final pickedFile = await picker.pickImage(source:ImageSource.gallery);
    if(pickedFile != null){
      _image = XFile(pickedFile.path);
      notifyListeners();
    }
  }

  Future pickCameraImage(BuildContext context)async{
    final pickedFile = await picker.pickImage(source:ImageSource.camera);
    if(pickedFile != null){
      _image = XFile(pickedFile.path);
      notifyListeners();
    }
  }


  void pickImage(context){
    showDialog(
        context: context,
        builder:(context){
          return AlertDialog(
            content: SizedBox(
              height: 120,
              child: Column(
                children: [
                  ListTile(
                    onTap: (){
                      pickCameraImage(context);
                      Navigator.of(context).pop();
                    },
                    leading: const Icon(Icons.camera),
                    title: const Text('Camera'),
                  ),
                  ListTile(
                    onTap: (){
                      pickGalleryImage(context);
                      Navigator.of(context).pop();
                    },
                    leading: const Icon(Icons.image),
                    title: const Text('Gallery'),
                  ),
                ],
              ),
            ),
          );
        });
  }


}