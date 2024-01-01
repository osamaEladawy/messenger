import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class HandelUploadImage {

  final String title = "Cloud Storage";
  final String text = "get Image Now ";


  ImagePicker image = ImagePicker();
  File? file1;
  File? filee;
  String url1 = "";

  String newUrl = "";

  String imageUrl = "";


  File? file;
  String? url;

  void Function(void Function())? setState;

  pickCameraImage() async {
    //create instance from imagePicker to get imageSource
    final ImagePicker picker = ImagePicker();

    //create instance from XFile to save into imageSource
    final XFile? imageCamera = await picker.pickImage(
        source: ImageSource.camera);

    //save instance from the XFile.path into var file
    if (imageCamera != null) {
      file = File(imageCamera.path);

      //update image steps
      //get name the file by
      var nameImage = basename(imageCamera.path);
      //create reference to save the file
      Reference referenceImage = FirebaseStorage.instance.ref('Images').child(
          nameImage);
      //put file into reference
      await referenceImage.putFile(file!);
      //to get the file or display
      url = await referenceImage.getDownloadURL();
    }
    if (setState != null) {
      setState!(() {});
    }
  }

  pickGalleryImage() async {
    //create instance from imagePicker to get imageSource
    final ImagePicker picker = ImagePicker();

    //create instance from XFile to save into imageSource
    final XFile? imageGallery = await picker.pickImage(
        source: ImageSource.gallery);

    //save instance from the XFile.path into var file
    if (imageGallery != null) {
      file = File(imageGallery.path);

      //update image steps
      //get name the file by
      var nameImage = basename(imageGallery.path);
      //create reference to save the file
      Reference referenceImage = FirebaseStorage.instance.ref(nameImage);
      //put file into reference
      await referenceImage.putFile(file!);
      //to get the file or display
      url = await referenceImage.getDownloadURL();
    }
    if (setState != null) {
      setState!(() {});
    }
  }

  pickImage(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            backgroundColor: Colors.grey[300],
            content: SizedBox(
              height: 120,
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      pickCameraImage();
                      Navigator.of(context).pop();
                    },
                    leading: const Icon(Icons.camera, color: Colors.red,),
                    title: const Text('Camera'),
                  ),
                  ListTile(
                    onTap: () {
                      pickGalleryImage();
                      Navigator.of(context).pop();
                    },
                    leading: const Icon(Icons.image, color: Colors.red),
                    title: const Text('Gallery'),
                  ),
                ],
              ),
            ),
            actions: [
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width - 20,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: const StadiumBorder(),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("cancel",
                      style: TextStyle(fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),),),
                ),
              ),
            ],
          );
        });
  }

}