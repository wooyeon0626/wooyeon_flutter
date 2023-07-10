import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:swipable_stack/swipable_stack.dart';
import 'package:wooyeon_flutter/widgets/icon_fill.dart';

import '../../config/palette.dart';

class CardControllerInDetail extends StatelessWidget {
  final SwipableStackController controller;

  const CardControllerInDetail(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 40,
      child: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: IconButton(
                onPressed: () {
                  controller.next(swipeDirection: SwipeDirection.left);
                  Navigator.of(context).pop();
                },
                icon: const IconFill(
                  size: 60,
                  icon: EvaIcons.close,
                  color: Palette.red,
                ),
                iconSize: 60,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: IconButton(
                onPressed: () {
                  controller.next(swipeDirection: SwipeDirection.right);
                  Navigator.of(context).pop();
                },
                icon: const IconFill(
                  size: 60,
                  icon: EvaIcons.heartOutline,
                  color: Palette.green,
                  iconSize: 40,
                ),
                iconSize: 60,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
