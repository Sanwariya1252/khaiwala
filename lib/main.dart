import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khaiwala/pages/splash_page.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(0xff009f75),
      systemNavigationBarColor: Color(0xff009f75),
    ),
  );

  WidgetsFlutterBinding.ensureInitialized();
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
        scaffoldBackgroundColor: Color(0xFFE8F5E9),
      ),
      home: SplashPage(),
    );
  }
}
