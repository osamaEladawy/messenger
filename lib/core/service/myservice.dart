import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Myservice {
  SharedPreferences? preferences;
  initializeMyService<Myservice>() async {
    preferences = await SharedPreferences.getInstance();
    await Firebase.initializeApp(
      options: Platform.isAndroid || Platform.isIOS
          ? const FirebaseOptions(
              apiKey: "AIzaSyB6nWEdGMHErxi8YhE-7sGkr9pDw_Qk61A",
              appId: "1:406224697890:android:23fc6bde8860a87b41e87b",
              messagingSenderId: "406224697890",
              projectId: "fir-messenger-966f0",
              storageBucket: "fir-messenger-966f0.appspot.com")
          : null,
    );
    return this;
  }
}
