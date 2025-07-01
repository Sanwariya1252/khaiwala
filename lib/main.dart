import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khaiwala/pages/splash_page.dart';
import 'package:khaiwala/styles/app_colors.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(0xff009f75),
      systemNavigationBarColor: Color(0xff009f75),
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KhaiWala',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Akaya",
        scaffoldBackgroundColor: AppColors.backGroundColor,
      ),
      home: SplashPage(),
    );
  }
}
