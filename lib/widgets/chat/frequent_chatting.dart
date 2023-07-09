import 'package:flutter/material.dart';
import 'package:wooyeon_flutter/screens/chat/chat_detail.dart';

import '../../config/palette.dart';
import '../../models/data/chat_room_data.dart';

class FrequentChatting extends StatelessWidget {
  final List<ChatRoom> items;
  const FrequentChatting(this.items, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      ChatDetail(chatRoom: items[index]),
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
              backgroundImage: NetworkImage(items[index].matched.profilePhoto[0]),
            ),
          );
        },
      ),
    );
  }
}
