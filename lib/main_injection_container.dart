
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:messenger_app/app/calls/call_injection_container.dart';
import 'package:messenger_app/app/chat/chat_injection_container.dart';
import 'package:messenger_app/app/status/status_injection_container.dart';
import 'package:messenger_app/app/user/user_injection_container.dart';



final sl = GetIt.instance;

Future<void> init() async {

  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;

  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => fireStore);
  

    await userInjectionContainer();
    await chatInjectionContainer();
    await statusInjectionContainer();
    await callInjectionContainer();
   //await rilesInjectionContainer();

}