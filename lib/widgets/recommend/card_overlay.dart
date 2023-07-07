import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:swipable_stack/swipable_stack.dart';

import 'card_label.dart';

class CardOverlay extends StatelessWidget {
  const CardOverlay({
    required this.direction,
    required this.swipeProgress,
    super.key,
  });
  final SwipeDirection direction;
  final double swipeProgress;

  @override
  Widget build(BuildContext context) {
    final opacity = swipeProgress <= 0.3
        ? 0.0
        : math.min<double>(swipeProgress - 0.3, 1);

    final isRight = direction == SwipeDirection.right;
    final isLeft = direction == SwipeDirection.left;
    return Stack(
      children: [
        Opacity(
          opacity: isRight ? opacity : 0,
          child: CardLabel.right(),
        ),
        Opacity(
          opacity: isLeft ? opacity : 0,
          child: CardLabel.left(),
        ),
      ],
    );
  }
}