import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:wooyeon_flutter/config/palette.dart';

class RecommendationAppbar extends StatefulWidget {
  const RecommendationAppbar({super.key});

  @override
  State<RecommendationAppbar> createState() => _RecommendationAppbar();
}

class _RecommendationAppbar extends State<RecommendationAppbar> {
  bool isNotificationReceived = false;

  void togglePressed() {
    setState(() {
      isNotificationReceived = !isNotificationReceived;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Image.asset(
                "assets/image/logo_wooyeon.png",
                fit: BoxFit.cover,
                width: 50,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Container(
                    alignment: Alignment.bottomRight,
                    child: Stack(children: [
                      IconButton(
                        onPressed: () {
                          togglePressed();
                        },
                        icon: const Icon(
                          EvaIcons.bell,
                          color: Palette.lightGrey,
                        ),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent, // 물결 효과 비활성화
                      ),
                      Positioned(
                        left: 25,
                        top: 12,
                        child: SizedBox(
                          width: 10,
                          height: 10,
                          child: Opacity(
                            opacity: isNotificationReceived ? 1.0 : 0.0,
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(
                                color: Palette.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ])),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
