import 'package:flutter/material.dart';
import 'package:messenger/auth/chat_service.dart';
import 'package:messenger/views/auth/auth_page.dart';
import 'package:provider/provider.dart';

import 'auth/internet_service.dart';
import 'auth/profile_service.dart';
import 'auth/service_auth.dart';
import 'core/service/myservice.dart';
import 'my_chat.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Myservice().initializeMyService();

  runApp(
    MultiProvider(

      providers: [

        ChangeNotifierProvider(create: (context) => AuthServise(),),

        ChangeNotifierProvider(create: (context) => InternetServise(),),

        ChangeNotifierProvider(create: (context) => ProfileServise(),),

        ChangeNotifierProvider(create: (context) => ChatServise(),),

      ],

      child: const MyApp(),

    ),

  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:const AuthPage(),
    );
  }
}
