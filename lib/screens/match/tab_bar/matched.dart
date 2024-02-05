import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooyeon_flutter/models/controller/chat_controller.dart';
import 'package:wooyeon_flutter/widgets/chat/chatroom_listview.dart';

class Matched extends StatelessWidget {
  const Matched({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
      init: Get.find<ChatController>(),
      builder: (controller) => Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: ChatRoomListView(controller.newMatchedChatRooms),
      ),
    );
  }
}
