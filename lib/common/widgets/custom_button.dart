import 'dart:math';

import 'package:flutter/material.dart';

import 'package:amazon_clone/constant/global_variables.dart';

class CustomButton extends StatelessWidget {
  final String? customText;
  final VoidCallback onTap;
  final Color? buttoncolor;
  const CustomButton({
    Key? key,
    this.customText,
    required this.onTap,
    this.buttoncolor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        customText!,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
          backgroundColor: buttoncolor != null
              ? buttoncolor
              : GlobalVariables.secondaryColor,
          minimumSize: const Size(double.infinity, 50)),
    );
  }
}
