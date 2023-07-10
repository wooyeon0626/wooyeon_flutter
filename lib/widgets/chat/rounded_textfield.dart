import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class RoundedTextField extends StatefulWidget {
  final String hintText;
  final ValueChanged<String>? onSubmitted;
  const RoundedTextField({super.key, required this.hintText, required this.onSubmitted});

  @override
  State<RoundedTextField> createState() => _RoundedTextFieldState();
}

class _RoundedTextFieldState extends State<RoundedTextField> {
  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();

    void clearText() {
      setState(() {
        textEditingController.clear();
      });
    }

    void handleSubmitted(String value) {
      if (widget.onSubmitted != null) {
        widget.onSubmitted!(value);
      }
      clearText();
    }

    @override
    void dispose() {
      textEditingController.dispose();
      super.dispose();
    }

    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: const Icon(EvaIcons.search),
        border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20.0)),),
      ),
      onSubmitted: handleSubmitted,
    );
  }
}