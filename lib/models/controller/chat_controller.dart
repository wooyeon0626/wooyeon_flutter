import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooyeon_flutter/models/data/chat_data.dart';
import 'package:wooyeon_flutter/service/chat/chat_service.dart';
import '../data/chat_room_data.dart';

class ChatController extends GetxController {
  // key : chatRoomId, value : ChatRoom
  RxMap<int, ChatRoom> chatRooms =
      {for (var room in chatRoomData) room.chatRoomId: room}.obs;
  RxList<ChatRoom> chatRoomList = <ChatRoom>[].obs;
  RxList<ChatRoom> newMatchedChatRoomList = <ChatRoom>[].obs;

  final ScrollController scrollController = ScrollController();
  final showButton = false.obs;

  Future<void> loadChatRooms() async {
    // API 를 통해 chat room list 가져오기
    chatRooms.value = await ChatService.getChatRoomList();
    // newMatchedChatRooms update
    _updateNewMatchedChatRooms();
    // chatRoomList update
    chatRoomList.value = List.from(chatRooms.values);
    chatRoomList.sort(_compareChatOrder);
  }

  @override
  Future<void> onInit() async {
    super.onInit();

    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels == 0) {
          showButton.value = false;
        }
      } else if (!showButton.value) {
        showButton.value = true;
      }
    });
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  /*
      API 를 통해, 특정 chatRoomId 에 대한, 채팅 데이터 load
   */
  Future<void> loadChatData(int chatRoomId) async {
    ChatRoom room = chatRooms[chatRoomId]!;
    room.chat = await ChatService.getChatData(chatRoomId);
    update();
  }

  /*
      chatRoomId 를 통해, 해당 채팅방에 ChatData 추가
   */
  void addChatData(int chatRoomId, ChatData chatData) {
    ChatRoom room = chatRooms[chatRoomId]!;

    room.chat.add(chatData);
    update();

    _updateNewMatchedChatRooms();
  }

  void markChatsAsChecked(int chatRoomId) {
    ChatRoom? room = chatRooms[chatRoomId];

    if (room != null && room.chat.isNotEmpty) {
      for (var chat in room.chat.reversed) {
        if (!chat.isCheck) {
          chat.isCheck = true;
        } else {
          break;
        }
      }
      room.unReadChatCount = 0;
      update();
    }
  }

  void _updateNewMatchedChatRooms() {
    List<ChatRoom> rooms = List.from(chatRooms.values);
    List<ChatRoom> noChatRoomList = [];

    for (int i = 0; i < rooms.length; i++) {
      if (rooms[i].chat.isEmpty) {
        noChatRoomList.add(rooms[i]);
      }
    }

    newMatchedChatRoomList.value = noChatRoomList;
  }

  bool isContinuous(int chatRoomId, int index) {
    ChatRoom? room = chatRooms[chatRoomId];

    if (room != null && room.chat.isNotEmpty) {
      if (index >= 1 &&
          room.chat[index].isSender == room.chat[index - 1].isSender) {
        if (diffDate(chatRoomId, index)) {
          return false;
        }
        return true;
      }
      return false;
    }
    return false;
  }

  bool isDifferent(int chatRoomId, int index) {
    ChatRoom? room = chatRooms[chatRoomId];

    if (room != null && room.chat.isNotEmpty) {
      if (index == room.chat.length - 1) {
        return true;
      } else if (index < room.chat.length &&
          room.chat[index].isSender == room.chat[index + 1].isSender) {
        return true;
      }
      return false;
    }
    return false;
  }

  bool diffDate(int chatRoomId, int index) {
    ChatRoom? room = chatRooms[chatRoomId];

    if (room != null && room.chat.isNotEmpty) {
      if (index == 0) {
        return true;
      } else {
        final date1 = DateTime(room.chat[index].sendTime.year,
            room.chat[index].sendTime.month, room.chat[index].sendTime.day);
        final date2 = DateTime(
            room.chat[index - 1].sendTime.year,
            room.chat[index - 1].sendTime.month,
            room.chat[index - 1].sendTime.day);

        return date1 != date2;
      }
    }
    return false;
  }

  /*
    pin to top 속성 toggle 하는 함수
  */
  void togglePin(int chatRoomId) {
    if (chatRooms[chatRoomId] != null) {
      chatRooms[chatRoomId]!.pinToTop = !chatRooms[chatRoomId]!.pinToTop;
      update();
    }
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
