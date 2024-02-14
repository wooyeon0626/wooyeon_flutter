import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooyeon_flutter/widgets/chat/chatroom_list_item.dart';

import '../../models/controller/chat_controller.dart';
import '../../models/data/chat_room_data.dart';

class ChatRoomListView extends StatelessWidget {
  final List<ChatRoom> chatRoomList;

  const ChatRoomListView(this.chatRoomList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chatRoomList.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            ChatRoomListItem(
              chatRoomId: chatRoomList[index].chatRoomId,
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        );
      },
    );
  }


}
