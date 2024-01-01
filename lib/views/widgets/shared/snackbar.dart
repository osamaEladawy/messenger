import 'package:flutter/material.dart';

void openSnackBar(context,snackMessage,color){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: color,
    content: Text(snackMessage,style: const TextStyle(
        fontSize: 16
    ),),
    action: SnackBarAction(
        label: "Ok",
        textColor: Colors.white,
        onPressed: (){}),

  ));
}