import 'package:flutter/material.dart';

import '../../config/palette.dart';

class NewMessageNotification extends StatelessWidget {
  final String count;
  const NewMessageNotification(this.count, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            color: Palette.red
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.5, vertical: 2),
          child: Text(
            count,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }

}