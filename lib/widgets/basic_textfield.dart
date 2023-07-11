import 'package:flutter/material.dart';

class BasicTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType inputType;
  final bool autoFocus;
  const BasicTextField({required this.hintText, required this.controller, required this.inputType, required this.autoFocus, super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: 1,
      keyboardType: inputType,
      decoration: InputDecoration(
        hintText: hintText,
        border: const UnderlineInputBorder(),
      ),
      autofocus: autoFocus,
    );
  }

}