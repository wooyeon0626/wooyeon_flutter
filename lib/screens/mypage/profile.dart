import 'package:flutter/material.dart';
import 'package:wooyeon_flutter/config/palette.dart';
import 'package:wooyeon_flutter/service/auth.dart';

class Profile extends StatefulWidget {
  final double bodyHeight;

  const Profile(this.bodyHeight, {super.key});

  @override
  State<Profile> createState() => _Profile();
}

class _Profile extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
      onPressed: () {
        Auth().logout();
      },
      child: Container(
        color: Palette.primary,
        height: 80,
        width: 250,
        child: const Center(
          child: Text(
            '로그아웃', style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
          ),
        ),
      ),
    ));
  }
}
