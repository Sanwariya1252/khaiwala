import 'package:flutter/material.dart';
import 'package:khaiwala/styles/app_colors.dart';

class WinnerPage extends StatelessWidget {
  const WinnerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          "Win & Loss Details",
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
