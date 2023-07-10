import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooyeon_flutter/screens/chat/chat_detail.dart';

import '../../config/palette.dart';
import '../../models/controller/chat_controller.dart';

class FrequentChatting extends StatelessWidget {
  const FrequentChatting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
      init: Get.find<ChatController>(),
      builder: (controller) {
        var frequentChatRooms = controller.frequentChatting;
        return SizedBox(
          height: 80.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: frequentChatRooms.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          ChatDetail(chatRoomId: frequentChatRooms[index].chatRoomId),
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
                },
                child: CircleAvatar(
                  radius: 50.0,
                  backgroundColor: Palette.inactive,
                  backgroundImage: NetworkImage(frequentChatRooms[index].matched.profilePhoto[0]),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
