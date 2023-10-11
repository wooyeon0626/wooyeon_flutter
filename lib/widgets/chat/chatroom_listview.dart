import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooyeon_flutter/widgets/chat/chatroom_list_item.dart';

import '../../models/data/chat_room_data.dart';

class ChatRoomListView extends StatelessWidget {
  final RxMap<int, ChatRoom> chatRooms;

  const ChatRoomListView(this.chatRooms, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        itemCount: chatRooms.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ChatRoomListItem(
                chatRoomId: chatRooms.keys.elementAt(index),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          );
        },
      ),
    );
  }
}
