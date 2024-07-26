import 'package:firebase_core/firebase_core.dart';

class MyServices {
  Future<MyServices> init() async {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyB6nWEdGMHErxi8YhE-7sGkr9pDw_Qk61A",
          appId: "1:406224697890:android:ee7c651f1e46140241e87b",
          messagingSenderId: "406224697890",
          projectId: "fir-messenger-966f0",
          storageBucket: "fir-messenger-966f0.appspot.com"),
    );
    return this;
  }

  Future initializeService()async{
   return await MyServices().init();
  }
}
