import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:swipable_stack/swipable_stack.dart';
import 'package:wooyeon_flutter/widgets/icon_outline.dart';

import '../../config/palette.dart';

class CardController extends StatelessWidget {
  final SwipableStackController controller;

  const CardController(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 40,
        child: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: IconButton(
                  onPressed: () {
                    controller.next(swipeDirection: SwipeDirection.left);
                  },
                  icon: const IconOutline(
                    size: 60,
                    icon: EvaIcons.close,
                    color: Palette.red,
                  ),
                  iconSize: 60,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: IconButton(
                  onPressed: () {
                    controller.rewind();
                  },
                  icon: const IconOutline(
                    size: 60,
                    icon: EvaIcons.refresh,
                    color: Palette.yellow,
                    iconSize: 40,
                  ),
                  iconSize: 60,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                  onPressed: () {
                    controller.next(swipeDirection: SwipeDirection.right);
                  },
                  icon: const IconOutline(
                    size: 60,
                    icon: EvaIcons.heart,
                    color: Palette.green,
                    iconSize: 40,
                  ),
                  iconSize: 60,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
