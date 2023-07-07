import 'package:flutter/material.dart';

class Rounge extends StatefulWidget {
  const Rounge({super.key});

  @override
  State<Rounge> createState() => _Rounge();
}

class _Rounge extends State<Rounge> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("라운지"));
  }
}
