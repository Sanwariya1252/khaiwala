import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khaiwala/pages/set_mpin.dart';

class ForgotMPinPage extends StatefulWidget {
  final String phoneNumber;
  final String fullName;

  const ForgotMPinPage({
    super.key,
    required this.phoneNumber,
    required this.fullName,
  });

  @override
  State<ForgotMPinPage> createState() => _ForgotMPinPageState();
}

class _ForgotMPinPageState extends State<ForgotMPinPage> {
  final TextEditingController _otpController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _otpSent = false;
  int _secondsRemaining = 60;

  void _sendOtp() {
    setState(() {
      _otpSent = true;
      _secondsRemaining = 60;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Color(0xff009f75),
        content: Center(child: Text("OTP sent to your phone")),
        duration: Duration(seconds: 2),
      ),
    );

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        timer.cancel();
      } else {
        setState(() {
          _secondsRemaining--;
        });
      }
    });
  }

  void _verifyOtp() {
    if (_otpController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Center(child: Text("Please enter the OTP")),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SetMPinPage(
          fullName: widget.fullName,
          phoneNumber: widget.phoneNumber,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xff009f75),
        systemNavigationBarColor: Color(0xff009f75),
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 50.0),
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
                SizedBox(height: screenHeight * 0.04),

                const Text(
                  "Forgot M-PIN",
                  style: TextStyle(
                    color: Color(0xff7a65ae),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Barabara",
                  ),
                ),
                const SizedBox(height: 20),

                const Text(
                  "We'll send an OTP to your registered number",
                  style: TextStyle(
                    color: Color(0xff7a65ae),
                    fontSize: 16,
                    fontFamily: "Akaya",
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: _otpSent ? null : _sendOtp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff009f75),
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(
                      fontFamily: "Barabara",
                      fontWeight: FontWeight.bold,
                    ),
                    elevation: 6,
                  ),
                  child: Text(
                    _otpSent ? "Resend in $_secondsRemaining s" : "Send OTP",
                  ),
                ),
                const SizedBox(height: 25),

                if (_otpSent) ...[
                  TextFormField(
                    controller: _otpController,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    decoration: InputDecoration(
                      labelText: 'Enter OTP',
                      counterText: '',
                      labelStyle: const TextStyle(
                        color: Color(0xff009f75),
                        fontFamily: "Barabara",
                        fontSize: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      suffixIcon: const Icon(
                        Icons.security,
                        color: Color(0xff009f75),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _verifyOtp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff009f75),
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Barabara",
                        ),
                        elevation: 8,
                      ),
                      child: const Text("Verify & Reset M-PIN"),
                    ),
                  ),
                ],

                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Back to Login",
                    style: TextStyle(
                      color: Color(0xff009f75),
                      fontFamily: "Akaya",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
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
