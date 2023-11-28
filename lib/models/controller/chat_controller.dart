import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooyeon_flutter/models/data/chat_data.dart';
import '../data/chat_room_data.dart';

class ChatController extends GetxController {
  RxMap<int, ChatRoom> chatRooms =
      {for (var room in chatRoomData) room.chatRoomId: room}.obs;
  RxMap<int, ChatRoom> newMatchedChatRooms =
      {for (var room in chatRoomData) room.chatRoomId: room}.obs;
  final ScrollController scrollController = ScrollController();
  final showButton = false.obs;

  @override
  void onInit() {
    super.onInit();
    _updateNewMatchedChatRooms();

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
      update();
    }
  }

  void _updateNewMatchedChatRooms() {
    List<ChatRoom> rooms = List.from(chatRooms.values);
    Map<int, ChatRoom> noChatRooms = {};

    for (int i = 0; i < rooms.length; i++) {
      if (rooms[i].chat.isEmpty) {
        noChatRooms[i] = rooms[i];
        log(rooms[i].chatRoomId.toString());
      }
    }

    newMatchedChatRooms.value = noChatRooms;
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
  void togglePin(int chatRoomId){
    if(chatRooms[chatRoomId] != null){
      chatRooms[chatRoomId]!.pinToTop = !chatRooms[chatRoomId]!.pinToTop;
      update();
    }
  }
}
