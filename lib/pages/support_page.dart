import 'package:flutter/material.dart';
import 'package:khaiwala/styles/app_colors.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({super.key});

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          "Customer Care Support",
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Barabara"),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
