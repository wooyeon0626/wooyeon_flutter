import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  final double bodyHeight;
  const Profile(this.bodyHeight, {super.key});

  @override
  State<Profile> createState() => _Profile();
}

class _Profile extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("프로필"));
  }
}
