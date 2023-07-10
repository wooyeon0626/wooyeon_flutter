import 'package:flutter/material.dart';

class MatchAppbar extends StatelessWidget {
  const MatchAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
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
