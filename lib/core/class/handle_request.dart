import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HandelRequest extends StatelessWidget {
  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;
  final Widget child;
  const HandelRequest({super.key, required this.snapshot, required this.child});

  @override
  Widget build(BuildContext context) {
    return snapshot.hasError
        ? const Center(
            child: Text("Error..."),
          )
        : snapshot.connectionState == ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : !snapshot.hasData
                ? const Center(
                    child: Text("no data here"),
                  )
                : child;
  }
}
