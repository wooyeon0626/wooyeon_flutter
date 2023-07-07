import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../config/palette.dart';

const _labelAngle = math.pi / 2 * 0.3;

class CardLabel extends StatelessWidget {
  const CardLabel._({
    required this.color,
    required this.label,
    required this.angle,
    required this.alignment,
  });

  factory CardLabel.right() {
    return const CardLabel._(
      color: Palette.green,
      label: '좋아요',
      angle: -_labelAngle,
      alignment: Alignment.topLeft,
    );
  }

  factory CardLabel.left() {
    return const CardLabel._(
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
        vertical: 60,
        horizontal: 36,
      ),
      child: Transform.rotate(
        angle: angle,
        child: Container(
          width: 120.0,
          height: 60.0,
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
                  fontSize: 24
              ),
            ),
          ),
        ),
      ),
    );
  }
}