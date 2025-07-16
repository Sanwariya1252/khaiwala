import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khaiwala/pages/forgot_pass.dart';
import 'package:khaiwala/pages/home_page.dart';
import 'package:khaiwala/pages/register_page.dart';
import 'package:khaiwala/styles/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  final String? fullName;
  final String? mobileNumber;
  const LoginPage({super.key, this.fullName, this.mobileNumber});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xff009f75),
        systemNavigationBarColor: Color(0xff009f75),
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Hello, Welcome to KhaiWala",
                      style: TextStyle(
                        color: Color(0xff7a65ae),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Barabara",
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Login to continue",
                      style: TextStyle(
                        color: Color(0xff7a65ae),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Akaya",
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
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
                        } else if (value.length != 10) {
                          return 'Enter valid 10-digits number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      textInputAction: TextInputAction.go,
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      obscuringCharacter: '*',
                      decoration: InputDecoration(
                        labelText: 'Your Password',
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
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Color(0xff009f75),
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.length < 4) {
                          return 'Enter your verified password';
                        }
                        return null;
                      },
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgotPass(),
                            ),
                          );
                        },
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: Color(0xff009f75),
                            fontFamily: "Akaya",
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => HomePage(
                                  fullName: widget.fullName,
                                  mobileNumber: widget.mobileNumber,
                                ),
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
                        child: const Text("Login"),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "OR",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff7a65ae),
                        fontFamily: "Barabara",
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          final phone = "919887766288";
                          final message = Uri.encodeComponent(
                            "Hi, I want to Play",
                          );
                          final whatsappUrl = Uri.parse(
                            "https://wa.me/$phone?text=$message",
                          );

                          if (await canLaunchUrl(whatsappUrl)) {
                            await launchUrl(
                              whatsappUrl,
                              mode: LaunchMode.externalApplication,
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: AppColors.headingColor,
                                content: const Center(
                                  child: Text(
                                    "Could not open WhatsApp",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                        icon: ClipOval(
                          child: Image.asset(
                            "assets/images/whatsapp.png",
                            width: 24,
                            height: 24,
                            fit: BoxFit.cover,
                          ),
                        ),
                        label: const Text(
                          "Login with WhatsApp",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Akaya",
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[100],
                          foregroundColor: Color(0xff009f75),
                          elevation: 8,
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Barabara",
                            color: Color(0xff7a65ae),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterPage(),
                              ),
                            );
                          },
                          child: const Text(
                            "Register Now",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff009f75),
                              fontFamily: "Barabara",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
