import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khaiwala/pages/forgot_pass.dart';
import 'package:khaiwala/pages/register_page.dart';
import 'package:khaiwala/styles/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  _LoginPageState();

  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xff009f75),
        systemNavigationBarColor: Color(0xff009f75),
      ),
    );
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    double getResponsiveFont(double base) => base * (width / 375);

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.06,
              vertical: height * 0.03,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height * 0.01),
                Text(
                  "Hello, Welcome to KhaiWala",
                  style: TextStyle(
                    color: const Color(0xff7a65ae),
                    fontSize: getResponsiveFont(22),
                    fontWeight: FontWeight.bold,
                    fontFamily: "Barabara",
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: height * 0.06),
                Text(
                  "Login to Continue..",
                  style: TextStyle(
                    color: const Color(0xff7a65ae),
                    fontSize: getResponsiveFont(22),
                    fontWeight: FontWeight.bold,
                    fontFamily: "Akaya",
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: height * 0.025),
                TextField(
                  style: TextStyle(
                    fontFamily: "Akaya",
                    fontSize: getResponsiveFont(20),
                    color: Color(0xff009f75),
                    fontWeight: FontWeight.bold,
                  ),
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  maxLength: 10,
                  buildCounter:
                      (
                        _, {
                        required currentLength,
                        required isFocused,
                        required maxLength,
                      }) => null,
                  cursorColor: Color(0xff009f75),
                  decoration: InputDecoration(
                    labelText: 'Mobile Number',
                    labelStyle: TextStyle(
                      color: Color(0xff009f75),
                      fontFamily: "Barabara",
                      fontSize: getResponsiveFont(16),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                    suffixIcon: Icon(
                      Icons.phone_android,
                      color: Color(0xff009f75),
                      size: getResponsiveFont(25),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.022),
                TextField(
                  style: TextStyle(
                    fontFamily: "Akaya",
                    fontSize: getResponsiveFont(20),
                    color: Color(0xff009f75),
                    fontWeight: FontWeight.bold,
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.go,
                  cursorColor: Color(0xff009f75),
                  obscuringCharacter: '*',
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Your Password',
                    labelStyle: TextStyle(
                      color: Color(0xff009f75),
                      fontFamily: "Barabara",
                      fontSize: getResponsiveFont(16),
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
                        size: getResponsiveFont(22),
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForgotPass()),
                      );
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Color(0xff009f75),
                      textStyle: TextStyle(
                        fontFamily: "Akaya",
                        fontSize: getResponsiveFont(16),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text("Forgot Password ?"),
                  ),
                ),
                SizedBox(height: height * 0.02),
                SizedBox(
                  width: double.infinity,
                  height: height * 0.065,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigator.pushNamed()
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff009f75),
                      foregroundColor: Colors.white,
                      textStyle: TextStyle(
                        fontFamily: "Barabara",
                        fontSize: getResponsiveFont(22),
                        fontWeight: FontWeight.w900,
                      ),
                      elevation: 11,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11.0),
                      ),
                    ),
                    child: const Text("Login"),
                  ),
                ),
                SizedBox(height: height * 0.05),
                Text(
                  "OR",
                  style: TextStyle(
                    fontFamily: "Barabara",
                    fontSize: getResponsiveFont(33),
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff7a65ae),
                  ),
                ),
                SizedBox(height: height * 0.02),
                SizedBox(
                  height: height * 0.065,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final phone = "919887766288";
                      final message = Uri.encodeComponent("Hi, I want to Play");
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
                            content: Center(
                              child: Text(
                                "Could not open WhatsApp",
                                style: TextStyle(fontSize: 11),
                              ),
                            ),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[100],
                      foregroundColor: Color(0xff009f75),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(33.0),
                      ),
                      elevation: 11,
                      textStyle: TextStyle(
                        fontSize: getResponsiveFont(20),
                        fontWeight: FontWeight.bold,
                        fontFamily: "Akaya",
                      ),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.asset(
                              "assets/images/whatsapp.png",
                              width: getResponsiveFont(33),
                              height: getResponsiveFont(33),
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: width * 0.025),
                          const Text("Login with WhatsApp"),
                          SizedBox(width: width * 0.025),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.asset(
                              "assets/images/whatsapp.png",
                              width: getResponsiveFont(33),
                              height: getResponsiveFont(33),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.06),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account ?",
                        style: TextStyle(
                          color: const Color(0xff7a65ae),
                          fontFamily: "Barabara",
                          fontSize: getResponsiveFont(15),
                          fontWeight: FontWeight.bold,
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
                        style: TextButton.styleFrom(
                          foregroundColor: Color(0xff009f75),
                          textStyle: TextStyle(
                            fontFamily: "Barabara",
                            fontSize: getResponsiveFont(18),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: const Text("Register Now"),
                      ),
                    ],
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
