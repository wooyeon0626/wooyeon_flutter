import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooyeon_flutter/widgets/chat/chatroom_list_item.dart';

import '../../models/data/chat_room_data.dart';

class ChatRoomListView extends StatelessWidget {
  final RxMap<int, ChatRoom> chatRooms;

  const ChatRoomListView(this.chatRooms, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ChatRoom> chatRoomList = List.from(chatRooms.values);
    chatRoomList.sort(_compareChatOrder);

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

  /*
    chatRoom 순서 정렬, pinToTop 속성, chat 데이터 유무 및 마지막 채팅 시간 고려
  */
  int _compareChatOrder(ChatRoom a, ChatRoom b) {
    if (a.pinToTop && b.pinToTop) {
      if (a.chat.isEmpty && b.chat.isEmpty) {
        return 0;
      } else if (a.chat.isEmpty && b.chat.isNotEmpty) {
        return 1;
      } else if (a.chat.isNotEmpty && b.chat.isEmpty) {
        return -1;
      } else {
        return b.chat.last.sendTime.compareTo(a.chat.last.sendTime); // 내림치순
      }
    } else if (a.pinToTop && b.pinToTop == false) {
      return -1;
    } else if (a.pinToTop == false && b.pinToTop) {
      return 1;
    } else {
      if (a.chat.isEmpty && b.chat.isEmpty) {
        return 0;
      } else if (a.chat.isEmpty && b.chat.isNotEmpty) {
        return 1;
      } else if (a.chat.isNotEmpty && b.chat.isEmpty) {
        return -1;
      } else {
        return b.chat.last.sendTime.compareTo(a.chat.last.sendTime); // 내림치순
      }
    }
  }
}
