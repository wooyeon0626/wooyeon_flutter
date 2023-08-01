import 'package:flutter/material.dart';
import 'package:wooyeon_flutter/config/palette.dart';

void showCustomSnackBar({required BuildContext context, required String text, Color color = Palette.secondary}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      content: Center(
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    ),
  );
}
