import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../config/palette.dart';

const _labelAngle = math.pi / 2 * 0.3;

class LikeFromCardLabel extends StatelessWidget {
  const LikeFromCardLabel._({
    required this.color,
    required this.label,
    required this.angle,
    required this.alignment,
  });

  factory LikeFromCardLabel.right() {
    return const LikeFromCardLabel._(
      color: Palette.green,
      label: '좋아요',
      angle: -_labelAngle,
      alignment: Alignment.topLeft,
    );
  }

  factory LikeFromCardLabel.left() {
    return const LikeFromCardLabel._(
      color: Palette.red,
      label: '넘기기',
      angle: _labelAngle,
      alignment: Alignment.topRight,
    );
  }

  final Color color;
  final String label;
  final double angle;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      padding: const EdgeInsets.symmetric(
        vertical: 40,
        horizontal: 24,
      ),
      child: Transform.rotate(
        angle: angle,
        child: Container(
          width: 100.0,
          height: 50.0,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
            ),
          ),
        ),
      ),
    );
  }
}