import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooyeon_flutter/models/data/chat_data.dart';
import '../data/chat_room_data.dart';

class ChatController extends GetxController {
  RxMap<int, ChatRoom> chatRooms =
      {for (var room in chatRoomData) room.chatRoomId: room}.obs;
  RxList<ChatRoom> frequentChatting = List<ChatRoom>.empty(growable: true).obs;
  final ScrollController scrollController = ScrollController();
  final showButton = false.obs;

  @override
  void onInit() {
    super.onInit();
    _updateFrequentChatting();

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

  void addMessage(int chatRoomId, String message) {
    ChatRoom room = chatRooms[chatRoomId]!;

    int newChatId = room.chat == null || room.chat!.isEmpty
        ? 0
        : room.chat!.last.chatId + 1;

    ChatData newChat = ChatData(
        chatId: newChatId,
        isSender: true,
        message: message,
        sendTime: DateTime.now(),
        isCheck: true);

    room.chat ??= <ChatData>[];

    room.chat!.add(newChat);
    update();

    _updateFrequentChatting();
  }

  void markChatsAsChecked(int chatRoomId) {
    ChatRoom? room = chatRooms[chatRoomId];

    if (room != null && room.chat != null) {
      for (var chat in room.chat!.reversed) {
        if (!chat.isCheck) {
          chat.isCheck = true;
        } else {
          break;
        }
      }
      update();
    }
  }

  void _updateFrequentChatting() {
    List<ChatRoom> sortedRooms = List.from(chatRooms.values);
    sortedRooms.sort((a, b) => a.frequent.compareTo(b.frequent));
    frequentChatting.value = sortedRooms.take(6).toList();
  }

  bool isContinuous(int chatRoomId, int index) {
    ChatRoom? room = chatRooms[chatRoomId];

    if (room != null && room.chat != null) {
      if (index >= 1 &&
          room.chat![index].isSender == room.chat![index - 1].isSender) {
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

    if (room != null && room.chat != null) {
      if (index == room.chat!.length - 1) {
        return true;
      } else if (index < room.chat!.length &&
          room.chat![index].isSender == room.chat![index + 1].isSender) {
        return true;
      }
      return false;
    }
    return false;
  }

  bool diffDate(int chatRoomId, int index) {
    ChatRoom? room = chatRooms[chatRoomId];

    if (room != null && room.chat != null) {
      if (index == 0) {
        return true;
      } else {
        final date1 = DateTime(room.chat![index].sendTime.year,
            room.chat![index].sendTime.month, room.chat![index].sendTime.day);
        final date2 = DateTime(
            room.chat![index - 1].sendTime.year,
            room.chat![index - 1].sendTime.month,
            room.chat![index - 1].sendTime.day);

        return date1 != date2;
      }
    }
    return false;
  }
}
