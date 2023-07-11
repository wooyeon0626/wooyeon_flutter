import 'package:flutter/material.dart';

class Lounge extends StatefulWidget {
  final double bodyHeight;
  const Lounge(this.bodyHeight, {super.key});

  @override
  State<Lounge> createState() => _Lounge();
}

class _Lounge extends State<Lounge> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("라운지"));
  }
}
