import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import '../../config/palette.dart';
import '../../models/controller/chat_controller.dart';
import 'chat_list_item.dart';

class ChatListView extends GetView<ChatController> {
  final int chatRoomId;
  const ChatListView(this.chatRoomId, {super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(
      children: [
        ListView.builder(
          controller: controller.scrollController,
          itemCount: controller.chatRooms[chatRoomId]!.chat.length,
          reverse: true,
          itemBuilder: (context, index) {
            final realIndex = controller.chatRooms[chatRoomId]!.chat.length - 1 - index;
            return Padding(
              padding: EdgeInsets.only(
                  bottom: controller.isDifferent(chatRoomId, realIndex) ? 3 : 8),
              child: Column(
                children: [
                  if (controller.diffDate(chatRoomId, realIndex))
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                            DateFormat('MM월 dd일', 'ko_KR')
                                .format(controller.chatRooms[chatRoomId]!.chat[realIndex].sendTime),
                            style: const TextStyle(fontWeight: FontWeight.bold, color: Palette.black, fontSize: 16)),
                      ),
                    ),
                  ChatListItem(controller.chatRooms[chatRoomId]!.chat[realIndex],
                      controller.isContinuous(chatRoomId, realIndex)),
                ],
              ),
            );
          },
        ),
        Positioned(
          right: 20,
          bottom: 20,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: controller.showButton.value ? 1 : 0,
            child: FloatingActionButton(
              mini: true,
              child: const Icon(EvaIcons.arrowIosDownward),
              onPressed: () {
                controller.scrollController.animateTo(
                  controller.scrollController.position.minScrollExtent,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOut,
                );
              },
            ),
          ),
        ),
      ],
    ));
  }
}
