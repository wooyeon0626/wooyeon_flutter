import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:wooyeon_flutter/config/palette.dart';

class ChatAppbar extends StatefulWidget {
  const ChatAppbar({super.key});

  @override
  State<ChatAppbar> createState() => _RecommendationAppbar();
}

class _RecommendationAppbar extends State<ChatAppbar> {
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
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "채팅",
              style: TextStyle(
                color: Palette.black,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
              textAlign: TextAlign.left,
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: Stack(
                children: [
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
