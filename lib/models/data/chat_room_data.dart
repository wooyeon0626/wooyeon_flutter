import 'package:wooyeon_flutter/models/data/chat_data.dart';
import 'match_data.dart';

class ChatRoom {
  int chatRoomId;
  bool isOnline;
  MatchProfiles matched;
  List<ChatData>? chat;
  int frequent;

  ChatRoom(
      {required this.chatRoomId,
      required this.isOnline,
      required this.matched,
      this.chat,
      required this.frequent});
}

List<ChatRoom> chatRoomData = [
  ChatRoom(chatRoomId: 0, isOnline: true, matched: matchProfiles[0], chat: chatData, frequent: 0),
  ChatRoom(chatRoomId: 1, isOnline: false, matched: matchProfiles[1], chat: chatData2, frequent: 2),
  ChatRoom(chatRoomId: 2, isOnline: true, matched: matchProfiles[2], chat: chatData3, frequent: 4),
  ChatRoom(chatRoomId: 3, isOnline: false, matched: matchProfiles[3], chat: chatData4, frequent: 1),
  ChatRoom(chatRoomId: 4, isOnline: true, matched: matchProfiles[4], chat: null, frequent: 3),
  ChatRoom(chatRoomId: 5, isOnline: true, matched: matchProfiles[0], chat: null, frequent: 5),
  ChatRoom(chatRoomId: 6, isOnline: false, matched: matchProfiles[1], chat: null, frequent: 6),
  ChatRoom(chatRoomId: 7, isOnline: true, matched: matchProfiles[2], chat: null, frequent: 7),
  ChatRoom(chatRoomId: 8, isOnline: false, matched: matchProfiles[3], chat: null, frequent: 8),
  ChatRoom(chatRoomId: 9, isOnline: true, matched: matchProfiles[4], chat: null, frequent: 9),
];
