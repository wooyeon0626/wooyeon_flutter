import 'package:flutter/material.dart';

import '../../config/palette.dart';

class ProfileProgressBar extends StatefulWidget {

  final double start;
  final double end;

  const ProfileProgressBar({required this.start, required this.end, super.key});

  @override
  State<ProfileProgressBar> createState() => _ProfileProgressBarState();
}

class _ProfileProgressBarState extends State<ProfileProgressBar> {
  late double width;

  @override
  void initState() {
    super.initState();
    width = widget.start;
    animateWidth();
  }

  void animateWidth() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      width = widget.end;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: MediaQuery.of(context).size.width * width,
      height: 4.0,
      alignment: Alignment.centerLeft,
      color: Palette.primary,
    );
  }
}
