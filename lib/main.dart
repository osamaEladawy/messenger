import 'package:flutter/material.dart';
import 'package:messenger_app/core/class/handel_image.dart';
import 'package:messenger_app/providers/auth_service.dart';
import 'package:messenger_app/providers/users_providers.dart';
import 'package:messenger_app/services/my_services.dart';
import 'package:messenger_app/views/splash/splash_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/theme/style.dart';

late SharedPreferences preferences;

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  preferences = await SharedPreferences.getInstance();
  await MyServices().initializeService();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => UsersProviders()),
        ChangeNotifierProvider(create: (context) => HandleImage()),
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
            )),
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
      home: SplashPage(),
    );
  }
}
