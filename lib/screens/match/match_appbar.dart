import 'package:flutter/material.dart';

class MatchAppbar extends StatelessWidget {
  const MatchAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Image.asset(
            "assets/image/logo_wooyeon.png",
            fit: BoxFit.cover,
            width: 50,
          ),
        ),
      ),
    );
  }
}
