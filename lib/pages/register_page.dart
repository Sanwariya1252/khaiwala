import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khaiwala/pages/login_page.dart';
import 'package:khaiwala/styles/app_colors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _fullNameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _referenceController = TextEditingController();

  final _fullNameFocus = FocusNode();
  final _mobileFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();
  final _referenceFocus = FocusNode();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xff009f75),
        systemNavigationBarColor: Color(0xff009f75),
      ),
    );
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _referenceController.dispose();

    _fullNameFocus.dispose();
    _mobileFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
    _referenceFocus.dispose();

    super.dispose();
  }

  double getResponsiveFont(double size, double screenWidth) {
    return size * (screenWidth / 375);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.06,
            vertical: screenHeight * 0.02,
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
                      height: screenWidth * 0.33,
                      width: screenWidth * 0.33,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.025),

                // Full Name
                _buildTextFormField(
                  controller: _fullNameController,
                  label: "Full Name",
                  icon: Icons.person_pin,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Enter your full name";
                    }
                    return null;
                  },
                  screenWidth: screenWidth,
                  focusNode: _fullNameFocus,
                  nextFocusNode: _mobileFocus,
                ),
                SizedBox(height: screenHeight * 0.025),

                // Mobile Number
                _buildTextFormField(
                  controller: _mobileController,
                  label: "Mobile Number",
                  icon: Icons.phone_iphone,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Enter your mobile number";
                    } else if (value.length != 10) {
                      return "Enter 10-digits mobile number";
                    }
                    return null;
                  },
                  screenWidth: screenWidth,
                  focusNode: _mobileFocus,
                  nextFocusNode: _passwordFocus,
                ),
                SizedBox(height: screenHeight * 0.025),

                // Create Password
                _buildPasswordFormField(
                  controller: _passwordController,
                  label: "Create Password",
                  obscureText: _obscurePassword,
                  onToggle: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Create your own password";
                    } else if (value.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                  screenWidth: screenWidth,
                  focusNode: _passwordFocus,
                  nextFocusNode: _confirmPasswordFocus,
                ),
                SizedBox(height: screenHeight * 0.025),

                // Confirm Password
                _buildPasswordFormField(
                  controller: _confirmPasswordController,
                  label: "Confirm Password",
                  obscureText: _obscureConfirmPassword,
                  onToggle: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please verify your password";
                    } else if (value != _passwordController.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                  screenWidth: screenWidth,
                  focusNode: _confirmPasswordFocus,
                  nextFocusNode: _referenceFocus,
                ),
                SizedBox(height: screenHeight * 0.025),

                // Reference Code
                _buildTextFormField(
                  controller: _referenceController,
                  label: "Reference Code [optional]",
                  icon: Icons.integration_instructions_rounded,
                  keyboardType: TextInputType.text,
                  validator: (_) => null,
                  screenWidth: screenWidth,
                  focusNode: _referenceFocus,
                  nextFocusNode: null, // Last field: show "Done"
                ),
                SizedBox(height: screenHeight * 0.015),

                // Terms
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                  child: RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      text: "By registering, you agree to our ",
                      style: TextStyle(
                        color: AppColors.headingColor,
                        fontSize: getResponsiveFont(12, screenWidth),
                        fontFamily: "Akaya",
                      ),
                      children: [
                        TextSpan(
                          text: "Terms & Conditions ",
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(text: "and "),
                        TextSpan(
                          text: "Privacy Policy",
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),

                // Register Button
                SizedBox(
                  width: double.infinity,
                  height: screenHeight * 0.065,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => LoginPage(
                              fullName: _fullNameController.text.trim(),
                              mobileNumber: _mobileController.text.trim(),
                            ),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff009f75),
                      foregroundColor: Colors.white,
                      textStyle: TextStyle(
                        fontFamily: "Barabara",
                        fontSize: getResponsiveFont(20, screenWidth),
                        fontWeight: FontWeight.w900,
                      ),
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Register"),
                  ),
                ),
                SizedBox(height: screenHeight * 0.025),

                // Login Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already Registered ?",
                      style: TextStyle(
                        color: const Color(0xff7a65ae),
                        fontFamily: "Barabara",
                        fontSize: getResponsiveFont(14, screenWidth),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginPage()),
                        );
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xff009f75),
                      ),
                      child: Text(
                        "Login Now",
                        style: TextStyle(
                          fontFamily: "Barabara",
                          fontSize: getResponsiveFont(16, screenWidth),
                          fontWeight: FontWeight.bold,
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
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required TextInputType keyboardType,
    required String? Function(String?) validator,
    required double screenWidth,
    FocusNode? focusNode,
    FocusNode? nextFocusNode,
    int? maxLength,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      textInputAction: nextFocusNode != null
          ? TextInputAction.next
          : TextInputAction.done,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      validator: validator,
      onFieldSubmitted: (_) {
        if (nextFocusNode != null) {
          FocusScope.of(context).requestFocus(nextFocusNode);
        } else {
          FocusScope.of(context).unfocus();
        }
      },
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: AppColors.primaryColor,
          fontFamily: "Barabara",
          fontSize: getResponsiveFont(16, screenWidth),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.grey[100],
        suffixIcon: Icon(icon, color: AppColors.primaryColor),
        contentPadding: EdgeInsets.symmetric(
          vertical: screenWidth * 0.04,
          horizontal: screenWidth * 0.04,
        ),
        counterText: "",
      ),
    );
  }

  Widget _buildPasswordFormField({
    required TextEditingController controller,
    required String label,
    required bool obscureText,
    required VoidCallback onToggle,
    required String? Function(String?) validator,
    required double screenWidth,
    FocusNode? focusNode,
    FocusNode? nextFocusNode,
  }) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      obscureText: obscureText,
      obscuringCharacter: '*',
      textInputAction: nextFocusNode != null
          ? TextInputAction.next
          : TextInputAction.done,
      validator: validator,
      onFieldSubmitted: (_) {
        if (nextFocusNode != null) {
          FocusScope.of(context).requestFocus(nextFocusNode);
        } else {
          FocusScope.of(context).unfocus();
        }
      },
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: AppColors.primaryColor,
          fontFamily: "Barabara",
          fontSize: getResponsiveFont(16, screenWidth),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.grey[100],
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
            color: AppColors.primaryColor,
          ),
          onPressed: onToggle,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: screenWidth * 0.04,
          horizontal: screenWidth * 0.04,
        ),
      ),
    );
  }
}
