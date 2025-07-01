import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khaiwala/pages/login_page.dart';
import 'package:khaiwala/styles/app_colors.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xff009f75),
        systemNavigationBarColor: Color(0xff009f75),
      ),
    );

    final size = MediaQuery.of(context).size;
    final double imageSize = size.width * 0.6; // 60% of screen width
    final double verticalSpacing = size.height * 0.05; // 5% of screen height
    final double titleFontSize = size.width * 0.06; // Responsive font size
    final double subtitleFontSize = size.width * 0.08;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: AppColors.primaryColor,
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              child: SizedBox(
                height: size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: size.height * 0.13),
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(imageSize / 2),
                        child: Image.asset(
                          "assets/images/khaiwala.png",
                          width: imageSize,
                          height: imageSize,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: verticalSpacing),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.08,
                      ),
                      child: Text(
                        "Guess the right Number and Win More in Your faovrite Games",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Barabara",
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.bold,
                          color: AppColors.backGroundColor,
                        ),
                      ),
                    ),
                    SizedBox(height: verticalSpacing),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.08,
                      ),
                      child: Text(
                        "Let's Play Game On !",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: subtitleFontSize,
                          fontWeight: FontWeight.bold,
                          color: AppColors.backGroundColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: Lottie.asset(
                "assets/images/Floating.json",
                repeat: true,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
