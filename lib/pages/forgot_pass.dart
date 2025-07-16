import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khaiwala/pages/reset_pass.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();

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
              crossAxisAlignment: CrossAxisAlignment.center, // Start from top
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
                  "Forgot Password",
                  style: TextStyle(
                    color: Color(0xff7a65ae),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Barabara",
                  ),
                ),
                const SizedBox(height: 20),

                const Text(
                  "Enter your registered mobile number",
                  style: TextStyle(
                    color: Color(0xff7a65ae),
                    fontSize: 16,
                    fontFamily: "Akaya",
                  ),
                ),
                const SizedBox(height: 20),

                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  decoration: InputDecoration(
                    labelText: 'Mobile Number',
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
                      Icons.phone_iphone,
                      color: Color(0xff009f75),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter your registered number';
                    } else if (!RegExp(r'^\d{10}$').hasMatch(value.trim())) {
                      return 'Enter valid 10-digits number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ResetPasswordPage(),
                          ),
                        );
                      }
                    },
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
                    child: const Text("Send  OTP"),
                  ),
                ),
                const SizedBox(height: 16),

                Center(
                  child: TextButton(
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
