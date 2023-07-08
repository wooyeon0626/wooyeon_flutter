import 'package:flutter/material.dart';

class IconFill extends StatelessWidget {
  final double size;
  final IconData icon;
  final double? iconSize;
  final Color color;
  const IconFill({required this.size, required this.icon, required this.color, this.iconSize, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Center(
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color
          ),
        ),
      ),
      Positioned(
        child: Center(
          child: Icon(
            icon,
            color: Colors.white,
            size: iconSize ?? size / 4 * 3,
          ),
        ),
      ),
    ]);
  }
}