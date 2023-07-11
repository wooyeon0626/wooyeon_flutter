import 'package:flutter/material.dart';
import 'package:wooyeon_flutter/config/palette.dart';

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
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                      nextPage!,
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = const Offset(1.0, 0.0);
                        var end = Offset.zero;
                        var curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    ),
                  );
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
