// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:khaiwala/pages/home_page.dart';
import 'package:khaiwala/pages/mpin_login.dart';
import 'package:khaiwala/pages/set_mpin.dart';
import 'package:local_auth/local_auth.dart';
import 'package:khaiwala/styles/app_colors.dart';

class VerifyPhonePage extends StatefulWidget {
  final String fullName;
  final String phoneNumber;

  final bool isForgotMpin;

  const VerifyPhonePage({
    super.key,
    required this.fullName,
    required this.phoneNumber,
    this.isForgotMpin = false,
  });

  @override
  State<VerifyPhonePage> createState() => _VerifyPhonePageState();
}

class _VerifyPhonePageState extends State<VerifyPhonePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _mpinController = TextEditingController();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  final LocalAuthentication _auth = LocalAuthentication();
  Timer? _resendTimer;
  int _secondsRemaining = 60;
  bool _canResend = false;
  bool _mpinRequired = false;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
    _checkBiometricAndAuthenticate();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xff009f75),
        systemNavigationBarColor: Color(0xff009f75),
      ),
    );
  }

  Future<void> _checkBiometricAndAuthenticate() async {
    try {
      final canCheckBiometrics = await _auth.canCheckBiometrics;
      final isBiometricSupported = await _auth.isDeviceSupported();
      final mpin = await _secureStorage.read(key: 'user_mpin');

      if (canCheckBiometrics && isBiometricSupported) {
        final authenticated = await _auth.authenticate(
          localizedReason: 'Please authenticate to continue',
          options: const AuthenticationOptions(
            biometricOnly: true,
            stickyAuth: true,
          ),
        );
        if (!authenticated && mpin != null) {
          setState(() => _mpinRequired = true);
        }
      } else {
        if (mpin != null) setState(() => _mpinRequired = true);
      }
    } catch (e) {
      debugPrint("Biometric check failed: $e");
      final mpin = await _secureStorage.read(key: 'user_mpin');
      if (mpin != null) setState(() => _mpinRequired = true);
    }
  }

  void _startResendTimer() {
    setState(() {
      _canResend = false;
      _secondsRemaining = 60;
    });

    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        timer.cancel();
        setState(() {
          _canResend = true;
        });
      } else {
        setState(() {
          _secondsRemaining--;
        });
      }
    });
  }

  Future<void> _verifyOtp() async {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppColors.headingColor,
          content: Center(child: Text("OTP Verified Successfully")),
          duration: Duration(seconds: 3),
        ),
      );

      final storedMpin = await _secureStorage.read(key: 'user_mpin');
      if (storedMpin == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SetMPinPage(
              fullName: widget.fullName,
              phoneNumber: widget.phoneNumber,
            ),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MpinLoginPage(
              fullName: widget.fullName,
              phoneNumber: widget.phoneNumber,
            ),
          ),
        );
      }
    }
  }

  Future<void> _verifyMpin() async {
    final storedMpin = await _secureStorage.read(key: 'user_mpin');
    if (_mpinController.text == storedMpin) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppColors.headingColor,
          content: Center(child: Text("M-PIN Verified Successfully")),
          duration: Duration(seconds: 3),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Center(child: Text("Invalid M-PIN")),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _otpController.dispose();
    _mpinController.dispose();
    _resendTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.08,
            vertical: screenHeight * 0.04,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child: Image.asset(
                      "assets/images/khaiwala.png",
                      height: screenWidth * 0.3,
                      width: screenWidth * 0.3,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                const Text(
                  "Phone Verification",
                  style: TextStyle(
                    color: Color(0xff7a65ae),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Barabara",
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Enter the OTP sent to your number",
                  style: TextStyle(
                    fontFamily: "Akaya",
                    fontSize: 14,
                    color: Color(0xff7a65ae),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                TextFormField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  autofocus: true,
                  autofillHints: const [AutofillHints.oneTimeCode],
                  decoration: InputDecoration(
                    labelText: 'Enter OTP',
                    labelStyle: const TextStyle(
                      color: Color(0xff009f75),
                      fontFamily: "Barabara",
                      fontSize: 16,
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    suffixIcon: const Icon(Icons.sms, color: Color(0xff009f75)),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter OTP';
                    }
                    return null;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: _canResend
                          ? () {
                              _startResendTimer();
                              ScaffoldMessenger.of(context).clearSnackBars();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Center(child: Text("OTP sent")),
                                  backgroundColor: AppColors.headingColor,
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          : null,
                      child: Text(
                        _canResend
                            ? "Resend OTP"
                            : "Resend in $_secondsRemaining s",
                        style: TextStyle(
                          fontFamily: "Akaya",
                          color: _canResend
                              ? const Color(0xff009f75)
                              : Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                if (_mpinRequired)
                  Column(
                    children: [
                      TextFormField(
                        controller: _mpinController,
                        obscureText: true,
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        decoration: InputDecoration(
                          labelText: 'Enter M-PIN',
                          labelStyle: const TextStyle(
                            color: Color(0xff009f75),
                            fontFamily: "Barabara",
                            fontSize: 16,
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          counterText: '',
                          suffixIcon: const Icon(
                            Icons.lock,
                            color: Color(0xff009f75),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.length != 6) {
                            return 'Enter 6-digit M-PIN';
                          }
                          return null;
                        },
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() => _mpinRequired = false);
                          _startResendTimer();
                        },
                        child: const Text(
                          "Forgot M-PIN?",
                          style: TextStyle(
                            color: Color(0xff009f75),
                            fontFamily: "Akaya",
                          ),
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: screenHeight * 0.03),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _mpinRequired ? _verifyMpin : _verifyOtp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff009f75),
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(
                        fontFamily: "Barabara",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: Text(
                      _mpinRequired ? "Login with M-PIN" : "Verify OTP",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
