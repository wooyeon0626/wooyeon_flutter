import 'package:flutter/material.dart';

class IconOutline extends StatelessWidget {
  final double size;
  final IconData icon;
  final double? iconSize;
  final Color color;
  final double? borderSize;

  const IconOutline(
      {required this.size,
      required this.icon,
      required this.color,
      this.borderSize,
      this.iconSize,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        top: 0,
        bottom: 0,
        left: 0,
        right: 0,
        child: Icon(
          icon,
          color: color,
          size: iconSize ?? size / 4 * 3,
        ),
      ),
      Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: color,
            width: borderSize ?? 3,
          ),
        ),
      ),
    ]);
  }
}
