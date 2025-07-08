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
  static const splashDuration = Duration(seconds: 8);

  @override
  void initState() {
    super.initState();

    // Set status and navigation bar color
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xff009f75),
        systemNavigationBarColor: Color(0xff009f75),
      ),
    );

    // Navigate to LoginPage after delay
    Timer(splashDuration, () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final screenWidth = constraints.maxWidth;
              final screenHeight = constraints.maxHeight;

              // Responsive sizes
              final double imageSize = screenWidth * 0.5; // 50% width
              final double spacing = screenHeight * 0.03;
              final double titleFontSize = screenWidth * 0.05;
              final double subtitleFontSize = screenWidth * 0.065;
              final double horizontalPadding = screenWidth * 0.08;

              return Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: AppColors.primaryColor,
                  ),

                  // Background animation
                  Positioned.fill(
                    child: IgnorePointer(
                      child: Lottie.asset(
                        "assets/images/Floating.json",
                        repeat: true,
                        animate: true,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // Foreground content with scroll protection
                  Center(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: spacing),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(imageSize / 2),
                            child: Image.asset(
                              "assets/images/khaiwala.png",
                              width: imageSize,
                              height: imageSize,
                              fit: BoxFit.cover,
                              semanticLabel: "Khaiwala Logo",
                            ),
                          ),
                          SizedBox(height: spacing),
                          Text(
                            "Guess the right Number and Win More in Your favorite Games",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "Barabara",
                              fontSize: titleFontSize,
                              fontWeight: FontWeight.bold,
                              color: AppColors.blackColor,
                            ),
                          ),
                          SizedBox(height: spacing * 1.5),
                          Text(
                            "Let's Play, Game On!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "Barabara",
                              fontSize: subtitleFontSize,
                              fontWeight: FontWeight.bold,
                              color: AppColors.blackColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
