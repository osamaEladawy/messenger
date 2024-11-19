import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:messenger_app/core/routes/on_generate_routes.dart';
import 'package:messenger_app/core/theme/style.dart';
import 'package:messenger_app/features/splash/splash_page.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          onGenerateRoute: OnGenerateRoute.route,
          title: 'Messenger App',
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              centerTitle: true,
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
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
          home: child,
        );
      },
      child: SplashPage(),
    );
  }
}

// flutter pub upgrade win32

// flutter pub cache clean

// flutter channel stable

// flutter clean && flutter pub get

// flutter pub upgrade
