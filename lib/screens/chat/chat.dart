import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooyeon_flutter/widgets/chat/chatroom_listview.dart';
import 'package:wooyeon_flutter/widgets/chat/rounded_textfield.dart';
import '../../models/controller/chat_controller.dart';

class Chat extends StatelessWidget {
  final double bodyHeight;

  const Chat(this.bodyHeight, {super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
      init: Get.find<ChatController>(),
      builder: (controller) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            RoundedTextField(
              hintText: '채팅방을 검색하세요',
              onSubmitted: (value) {
                log("Search : $value");
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ChatRoomListView(controller.chatRooms),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
