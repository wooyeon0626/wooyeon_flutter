import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooyeon_flutter/widgets/chat/chatroom_list_item.dart';

import '../../models/controller/chat_controller.dart';

class ChatRoomListView extends StatelessWidget {
  final ChatController chatController;

  const ChatRoomListView(this.chatController, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        itemCount: chatController.chatRoomList.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ChatRoomListItem(
                chatRoomId: chatController.chatRoomList[index].chatRoomId,
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
