import 'package:flutter/material.dart';

class Match extends StatefulWidget {
  const Match({super.key});

  @override
  State<Match> createState() => _Match();
}

class _Match extends State<Match> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("매치"));
  }
}
