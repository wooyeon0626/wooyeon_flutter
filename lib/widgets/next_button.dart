import 'package:flutter/material.dart';
import 'package:wooyeon_flutter/config/palette.dart';
import 'package:wooyeon_flutter/utils/transition.dart';

class NextButton extends StatelessWidget {
  final Widget? nextPage;
  final String text;
  final ValueNotifier<bool> isActive;
  final Function? func;

  const NextButton(
      {this.nextPage,
      required this.text,
      required this.isActive,
      this.func,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: isActive,
        builder: (BuildContext context, bool isActive, Widget? child) {
          return InkWell(
            onTap: () {
              if (isActive) {
                if (func == null && nextPage != null) {
                  navigateHorizontally(context: context, widget: nextPage!);
                } else if (func != null && nextPage == null) {
                  func!();
                }
              }
            },
            child: Container(
              height: 70,
              width: double.infinity,
              decoration: BoxDecoration(
                color: isActive ? Palette.primary : Palette.inactive,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    color: isActive ? Colors.white : Palette.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        });
  }
}
