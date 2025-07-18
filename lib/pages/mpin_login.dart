import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:khaiwala/pages/forgot_mpin.dart';
import 'package:khaiwala/pages/home_page.dart';
import 'package:local_auth/local_auth.dart';
import 'package:khaiwala/styles/app_colors.dart';

class MpinLoginPage extends StatefulWidget {
  final String fullName;
  final String phoneNumber;

  const MpinLoginPage({
    super.key,
    required this.fullName,
    required this.phoneNumber,
  });

  @override
  State<MpinLoginPage> createState() => _MpinLoginPageState();
}

class _MpinLoginPageState extends State<MpinLoginPage> {
  final TextEditingController _mpinController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final LocalAuthentication _auth = LocalAuthentication();
  bool _obscureMpin = true;

  @override
  void initState() {
    super.initState();
    _authenticateBiometric();
  }

  Future<void> _authenticateBiometric() async {
    try {
      final canCheckBiometrics = await _auth.canCheckBiometrics;
      final isSupported = await _auth.isDeviceSupported();

      if (canCheckBiometrics && isSupported) {
        final authenticated = await _auth.authenticate(
          localizedReason: 'Please authenticate to login',
          options: const AuthenticationOptions(
            biometricOnly: true,
            stickyAuth: true,
          ),
        );
        if (authenticated) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomePage()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Center(child: Text("Biometric authentication failed")),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (e) {
      debugPrint("Biometric error: $e");
    }
  }

  Future<void> _verifyMpin() async {
    if (_formKey.currentState!.validate()) {
      final storedMpin = await _secureStorage.read(key: 'user_mpin');
      if (_mpinController.text == storedMpin) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: AppColors.headingColor,
            content: Center(child: Text("M-PIN Verified")),
            duration: Duration(seconds: 2),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Center(child: Text("Invalid M-PIN")),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.08,
              vertical: screenHeight * 0.05,
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
                  SizedBox(height: screenHeight * 0.03),
                  const Text(
                    "Enter Your M-PIN",
                    style: TextStyle(
                      fontFamily: "Barabara",
                      fontSize: 22,
                      color: Color(0xff7a65ae),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Secure login using 6-digit M-PIN or fingerprint",
                    style: TextStyle(
                      fontFamily: "Akaya",
                      fontSize: 14,
                      color: Color(0xff7a65ae),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  TextFormField(
                    controller: _mpinController,
                    obscureText: _obscureMpin,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    decoration: InputDecoration(
                      labelText: "M-PIN",
                      labelStyle: const TextStyle(
                        fontFamily: "Barabara",
                        color: Color(0xff009f75),
                        fontSize: 16,
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      counterText: '',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureMpin
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: const Color(0xff009f75),
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureMpin = !_obscureMpin;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your M-PIN';
                      } else if (value.length != 6) {
                        return 'M-PIN must be 6 digits';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _verifyMpin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff009f75),
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(
                          fontFamily: "Barabara",
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: const Text("Login"),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ForgotMPinPage(
                            fullName: widget.fullName,
                            phoneNumber: widget.phoneNumber,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "Forgot M-PIN?",
                      style: TextStyle(
                        fontFamily: "Akaya",
                        color: Color(0xff009f75),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
