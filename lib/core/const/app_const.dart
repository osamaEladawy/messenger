


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:giphy_picker/giphy_picker.dart';
import 'package:messenger_app/core/theme/style.dart';

void toast( String message ) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: tabColor,
      textColor: whiteColor,
      fontSize: 16.0);
}

Future<GiphyGif?> pickGIF(BuildContext context) async {
  GiphyGif? gif;
  try {
    gif = await GiphyPicker.pickGif(
        context: context,
        apiKey:
        // 'kLu4PIKAwS2ys47Ji7oWUIr2iZbEoj1k',
    "vyYAFXahb2kXDdDgbbCHRC5hspN2CHF9",
    );

  } catch (e) {
    toast(e.toString());
  }

  return gif;
}