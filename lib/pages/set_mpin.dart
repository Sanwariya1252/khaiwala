import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:khaiwala/pages/home_page.dart';
import 'package:khaiwala/styles/app_colors.dart';

class SetMPinPage extends StatefulWidget {
  final String fullName;
  final String phoneNumber;

  const SetMPinPage({
    super.key,
    required this.fullName,
    required this.phoneNumber,
  });

  @override
  State<SetMPinPage> createState() => _SetMPinPageState();
}

class _SetMPinPageState extends State<SetMPinPage> {
  final TextEditingController _mpinController = TextEditingController();
  final TextEditingController _confirmMpinController = TextEditingController();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final _formKey = GlobalKey<FormState>();
  bool _obscureConfirmPassword = true;
  bool _obscureMpin = true;

  Future<void> _saveMpin() async {
    if (_formKey.currentState!.validate()) {
      if (_mpinController.text != _confirmMpinController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Center(child: Text("M-PINs do not match")),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      await _secureStorage.write(key: 'user_mpin', value: _mpinController.text);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppColors.headingColor,
          content: Center(child: Text("M-PIN Set Successfully")),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    }
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
                SizedBox(height: screenHeight * 0.03),
                const Text(
                  "Set Your M-PIN",
                  style: TextStyle(
                    fontFamily: "Barabara",
                    fontSize: 22,
                    color: Color(0xff7a65ae),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Secure your account with a 6-digit M-PIN",
                  style: TextStyle(
                    fontFamily: "Akaya",
                    fontSize: 14,
                    color: Color(0xff7a65ae),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.03),
                TextFormField(
                  controller: _mpinController,
                  obscureText: _obscureMpin,
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
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureMpin
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Color(0xff009f75),
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureMpin = !_obscureMpin;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.length != 6) {
                      return 'Enter a 6-digit M-PIN';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _confirmMpinController,
                  obscureText: _obscureConfirmPassword,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  decoration: InputDecoration(
                  labelText: 'Confirm M-PIN',
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
                  suffixIcon: IconButton(
                    icon: Icon(
                    _obscureConfirmPassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                    color: Color(0xff009f75),
                    ),
                    onPressed: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                    },
                  ),
                  ),
                  validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Confirm your 6-digit M-PIN';
                  } else if (value.length != 6) {
                    return 'M-PIN must be 6 digits';
                  } else if (value != _mpinController.text) {
                    return "M-PINs do not match";
                  }
                  return null;
                  },
                ),
                SizedBox(height: screenHeight * 0.04),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _saveMpin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff009f75),
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(
                        fontFamily: "Barabara",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text("Set M-PIN"),
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
