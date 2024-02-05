import 'package:flutter/material.dart';
import 'package:wooyeon_flutter/config/palette.dart';

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
        hintStyle: const TextStyle(color: Palette.grey, fontWeight: FontWeight.w300),
        border: const UnderlineInputBorder(),
      ),
      autofocus: autoFocus,
    );
  }
}