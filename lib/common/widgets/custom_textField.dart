import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  String? customHintText;
  TextEditingController custom_controller;
  int maxLines;
  CustomTextField(
      {Key? key,
      required this.customHintText,
      required this.custom_controller,
      this.maxLines = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      controller: custom_controller,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black38),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black38),
          ),
          hintText: customHintText),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return "Enter valid $customHintText";
        }
        return null;
      },
    );
  }
}
