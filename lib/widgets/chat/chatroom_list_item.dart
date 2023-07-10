import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooyeon_flutter/config/palette.dart';
import 'package:wooyeon_flutter/utils/util.dart';
import 'package:wooyeon_flutter/widgets/new_message_notification.dart';

import '../../models/controller/chat_controller.dart';
import '../../screens/chat/chat_detail.dart';

class ChatRoomListItem extends StatelessWidget {
  final int chatRoomId;

  const ChatRoomListItem({required this.chatRoomId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
      init: Get.find<ChatController>(),
      builder: (controller) {
        var chatRoom = controller.chatRooms[chatRoomId];
        if (chatRoom == null) return Container();  // This chat room doesn't exist

        int unChecked = chatRoom.chat?.where((chat) => chat.isCheck == false).length ?? 0;

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    ChatDetail(chatRoomId: chatRoomId),
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
      },
    );
  }
}
