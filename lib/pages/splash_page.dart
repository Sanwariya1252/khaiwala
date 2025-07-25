import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khaiwala/pages/home_page.dart';
import 'package:khaiwala/pages/login_page.dart';
import 'package:khaiwala/pages/verify_phone.dart';
import 'package:khaiwala/styles/app_colors.dart';
import 'package:khaiwala/utils/session_manager.dart';
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
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xff009f75),
        systemNavigationBarColor: Color(0xff009f75),
      ),
    );
    _startApp();
  }

  Future<void> _startApp() async {
    await SessionManager.init();

    // Optional: Show splash for a few seconds
    await Future.delayed(splashDuration);

    bool isLoggedIn = SessionManager.getBool('isLoggedIn');
    bool isOtpVerified = SessionManager.getBool('isOtpVerified');

    if (!isLoggedIn) {
      _goTo(const LoginPage());
    } else if (!isOtpVerified) {
      _goTo(const VerifyPhonePage(fullName: '', phoneNumber: '',));
    } else {
      _goTo(const HomePage());
    }
  }

  void _goTo(Widget page) {
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
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

              final imageSize = screenWidth * 0.5;
              final spacing = screenHeight * 0.03;
              final titleFontSize = screenWidth * 0.05;
              final subtitleFontSize = screenWidth * 0.065;
              final horizontalPadding = screenWidth * 0.08;

              return Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: AppColors.primaryColor,
                  ),
                  Positioned.fill(
                    child: IgnorePointer(
                      child: Lottie.asset(
                        "assets/images/Floating.json",
                        repeat: true,
                        animate: true,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(color: AppColors.primaryColor);
                        },
                      ),
                    ),
                  ),
                  Center(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                        vertical: spacing,
                      ),
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
