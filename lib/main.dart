import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:messenger_app/core/class/handel_image.dart';
import 'package:messenger_app/providers/auth_service.dart';
import 'package:messenger_app/providers/users_providers.dart';
import 'package:messenger_app/view/auth/initial_page.dart';
import 'package:messenger_app/view/auth/login_or_signup.dart';
import 'package:messenger_app/view/splash/splash_page.dart';
import 'package:provider/provider.dart';

import 'core/theme/style.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyB6nWEdGMHErxi8YhE-7sGkr9pDw_Qk61A",
        appId: "1:406224697890:android:ee7c651f1e46140241e87b",
        messagingSenderId: "406224697890",
        projectId: "fir-messenger-966f0",
        storageBucket: "fir-messenger-966f0.appspot.com"),
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthService(),
        ),
        ChangeNotifierProvider(
          create: (context) => UsersProviders(),
        ),
        ChangeNotifierProvider(
          create: (context) => HandleImage(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.black,
          )
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
           backgroundColor: backGroundColor,
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
         // backgroundColor: Colors.black,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.white70),
        ),
      ),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
    );
  }
}
