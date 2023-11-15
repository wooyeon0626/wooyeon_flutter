import 'package:wooyeon_flutter/models/data/chat_data.dart';
import 'match_data.dart';

class ChatRoom {
  int chatRoomId;
  bool isOnline;
  MatchProfiles matched;
  List<ChatData> chat;
  bool pinToTop;

  ChatRoom({
    required this.chatRoomId,
    required this.isOnline,
    required this.matched,
    required this.pinToTop,
    required this.chat,
  });
}

List<ChatRoom> chatRoomData = [
  ChatRoom(
    chatRoomId: 0,
    isOnline: true,
    matched: matchProfiles[0],
    chat: chatDataList,
    pinToTop: false,
  ),
  ChatRoom(
    chatRoomId: 1,
    isOnline: false,
    matched: matchProfiles[1],
    chat: chatDataList_2,
    pinToTop: false,
  ),
  ChatRoom(
    chatRoomId: 2,
    isOnline: true,
    matched: matchProfiles[2],
    chat: chatDataList_3,
    pinToTop: false,
  ),
  ChatRoom(
    chatRoomId: 3,
    isOnline: false,
    matched: matchProfiles[3],
    chat: chatDataList_4,
    pinToTop: false,
  ),
  ChatRoom(
    chatRoomId: 4,
    isOnline: true,
    matched: matchProfiles[4],
    chat: [],
    pinToTop: false,
  ),
  ChatRoom(
    chatRoomId: 5,
    isOnline: true,
    matched: matchProfiles[0],
    chat: [],
    pinToTop: false,
  ),
  ChatRoom(
    chatRoomId: 6,
    isOnline: false,
    matched: matchProfiles[1],
    chat: [],
    pinToTop: false,
  ),
  ChatRoom(
    chatRoomId: 7,
    isOnline: true,
    matched: matchProfiles[2],
    chat: [],
    pinToTop: false,
  ),
  ChatRoom(
    chatRoomId: 8,
    isOnline: false,
    matched: matchProfiles[3],
    chat: [],
    pinToTop: false,
  ),
  ChatRoom(
    chatRoomId: 9,
    isOnline: true,
    matched: matchProfiles[4],
    chat: [],
    pinToTop: false,
  ),
];
