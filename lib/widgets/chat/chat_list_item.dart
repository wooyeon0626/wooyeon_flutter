import 'package:flutter/material.dart';
import 'package:wooyeon_flutter/config/palette.dart';
import 'package:wooyeon_flutter/utils/util.dart';
import 'package:wooyeon_flutter/widgets/new_message_notification.dart';

import '../../models/data/chat_room_data.dart';
import '../../screens/chat/chat_detail.dart';

class ChatListItem extends StatelessWidget {
  final ChatRoom chatRoom;
  final int unChecked;

  ChatListItem(this.chatRoom, {super.key}) : unChecked = chatRoom.chat?.where((chat) => chat.isCheck == false).length ?? 0;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                ChatDetail(chatRoom: chatRoom),
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
      child: SizedBox(
        child: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(chatRoom.matched.profilePhoto[0]),
              radius: 32,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        chatRoom.matched.nickname,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      if (chatRoom.chat != null)
                        Text(formatDateTime(chatRoom.chat!.last.sendTime),
                          style: const TextStyle(fontSize: 12, color: Palette.grey),
                        ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: [
                              if (chatRoom.chat != null)
                                Text(
                                  chatRoom.chat!.last.message,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(color: Palette.grey),
                                )
                              else
                                const Text(
                                  "친구에게 먼저 말을 걸어보세요!",
                                  style: TextStyle(color: Palette.secondary),
                                ),
                            ],
                          ),
                        ),
                      ),
                      if (unChecked > 0)
                        NewMessageNotification(unChecked.toString()),
                    ],
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
