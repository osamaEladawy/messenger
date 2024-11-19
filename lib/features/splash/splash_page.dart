import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:messenger_app/views/auth/initial_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 3000)).then(
      (value) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const InitialPage(),
        ),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/messenger.png",
                  height: 100.h, width: 100.w),
              SizedBox(height: 40.h),
              Text(
                "Welcome to Messenger App",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                ),
              ),
              SizedBox(height: 10.h),
              // const Text(
              //   "Waiting to Go Home Page",
              //   style: TextStyle(
              //     fontWeight: FontWeight.bold,
              //     fontSize: 20,
              //   ),
              // ),
              Image.network(
                "https://www.icegif.com/wp-content/uploads/2023/07/icegif-1262.gif",
              )
            ],
          ),
        ),
      ),
    );
  }
}
