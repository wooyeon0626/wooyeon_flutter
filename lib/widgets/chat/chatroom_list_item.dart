import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooyeon_flutter/config/palette.dart';
import 'package:wooyeon_flutter/models/data/chat_room_data.dart';
import 'package:wooyeon_flutter/utils/util.dart';
import 'package:wooyeon_flutter/widgets/chat/new_message_notification.dart';

import '../../models/controller/chat_controller.dart';
import '../../screens/chat/chat_detail.dart';

class ChatRoomListItem extends StatelessWidget {
  final int chatRoomId;

  const ChatRoomListItem({required this.chatRoomId, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
      init: Get.find<ChatController>(),
      builder: (controller) {
        var chatRoom = controller.chatRooms[chatRoomId];
        if (chatRoom == null)
          return Container(); // This chat room doesn't exist

        // int unChecked = 0;
        // if (chatRoom.chat.isNotEmpty) {
        //   unChecked =
        //       chatRoom.chat.where((chat) => chat.isCheck == false).length;
        // }

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
          onLongPress: () {
            _showChatOptionDialog(context, controller);
          },
          child: SizedBox(
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage:
                      NetworkImage(chatRoom.profilePhoto),
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
                          Row(
                            children: [
                              Text(
                                chatRoom.nickname,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              if (chatRoom.pinToTop == true)
                                const Icon(
                                  Icons.push_pin_rounded,
                                  size: 15,
                                  color: Palette.lightGrey,
                                ),
                            ],
                          ),
                          if (chatRoom.chat.isNotEmpty)
                            Text(
                              formatDateTime(chatRoom.chat.last.sendTime),
                              style: const TextStyle(
                                  fontSize: 12, color: Palette.grey),
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
                                  if (chatRoom.chat.isNotEmpty)
                                    Text(
                                      chatRoom.chat.last.message,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          const TextStyle(color: Palette.grey),
                                    )
                                  else
                                    const Text(
                                      "친구에게 먼저 말을 걸어보세요!",
                                      style:
                                          TextStyle(color: Palette.secondary),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          if (chatRoom.unReadChatCount > 0)
                            NewMessageNotification(chatRoom.unReadChatCount.toString()),
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

  void _showChatOptionDialog(BuildContext context, ChatController controller) {
    ChatRoom chatRoom = controller.chatRooms[chatRoomId]!;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(chatRoom.nickname),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  controller.togglePin(chatRoomId);

                  Future.delayed(const Duration(milliseconds: 150), () {
                    Navigator.of(context).pop();
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: SizedBox(
                    width: double.infinity,
                    child: (chatRoom.pinToTop == false)
                        ? const Text('상단에 고정')
                        : const Text('고정 해제'),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Future.delayed(const Duration(milliseconds: 150), () {
                    Navigator.of(context).pop();
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: SizedBox(
                    width: double.infinity,
                    child: Text('채팅방 알람 끄기'),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Future.delayed(const Duration(milliseconds: 150), () {
                    Navigator.of(context).pop();
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: SizedBox(
                    width: double.infinity,
                    child: Text('차단'),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
