import 'package:wooyeon_flutter/models/data/chat_data.dart';
import 'match_data.dart';

class ChatRoom {
  int chatRoomId;
  bool isOnline;
  String profilePhoto;
  String nickname;
  List<ChatData> chat;
  bool pinToTop;
  int unReadChatCount;

  ChatRoom({
    required this.chatRoomId,
    required this.isOnline,
    required this.profilePhoto,
    required this.nickname,
    required this.pinToTop,
    required this.chat,
    required this.unReadChatCount,
  });

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    final int chatRoomId = json['chatRoomId'];
    final String nickname = json['nickname'];
    final String profilePhoto = json['profilePhoto'];
    final bool pinToTop = (json['pinToTop'] == 1);
    final String? recentMessage = json['recentMessage'];
    final String? recentTimeString = json['recentTime'];
    final bool? isSender =
        (json['isSender'] == null) ? null : (json['isSender'] == 1);
    final int unReadChatCount = json['unReadChatCount'];

    List<ChatData> chat = [];
    // 최근 채팅이 존재하면,
    if (recentMessage != null && recentTimeString != null && isSender != null) {
      DateTime recentTime = DateTime(
        int.parse(recentTimeString.split(',')[0]),
        int.parse(recentTimeString.split(',')[1]),
        int.parse(recentTimeString.split(',')[2]),
        int.parse(recentTimeString.split(',')[3]),
        int.parse(recentTimeString.split(',')[4]),
        int.parse(recentTimeString.split(',')[5]),
        int.parse(recentTimeString.split(',')[7]),
      );

      chat = [
        ChatData(
          chatId: 0,
          isSender: isSender,
          message: recentMessage,
          sendTime: recentTime,
          isCheck: true,
        ),
      ];
    }

    return ChatRoom(
      chatRoomId: chatRoomId,
      isOnline: true,
      profilePhoto: profilePhoto,
      nickname: nickname,
      pinToTop: pinToTop,
      chat: chat,
      unReadChatCount: unReadChatCount,
    );
  }
}

List<ChatRoom> chatRoomData = [
  ChatRoom(
    chatRoomId: 0,
    isOnline: true,
    profilePhoto: "https://i.imgur.com/qPDIdlc.jpeg",
    nickname: "유저1",
    chat: chatDataList,
    pinToTop: false,
    unReadChatCount: 3,
  ),
  ChatRoom(
    chatRoomId: 1,
    isOnline: false,
    profilePhoto: "https://i.imgur.com/KpPiNC7.jpeg",
    nickname: "DOGE",
    chat: chatDataList_2,
    pinToTop: false,
    unReadChatCount: 0,
  ),
  ChatRoom(
    chatRoomId: 2,
    isOnline: true,
    profilePhoto: "https://i.imgur.com/KpPiNC7.jpeg",
    nickname: "점메추",
    chat: chatDataList_3,
    pinToTop: false,
    unReadChatCount: 1,
  ),
  ChatRoom(
    chatRoomId: 3,
    isOnline: false,
    profilePhoto: "https://i.imgur.com/jNRHEsz.png",
    nickname: "닉네임 최대 몇 자?",
    chat: chatDataList_4,
    pinToTop: false,
    unReadChatCount: 0,
  ),
  ChatRoom(
    chatRoomId: 4,
    isOnline: true,
    profilePhoto: "https://i.imgur.com/qrtX0cK.jpeg",
    nickname: "qrtX0cK",
    chat: [],
    pinToTop: false,
    unReadChatCount: 0,
  ),
  ChatRoom(
    chatRoomId: 5,
    isOnline: true,
    profilePhoto: "https://i.imgur.com/KU3Ls9b.gif",
    nickname: "GIF",
    chat: [],
    pinToTop: false,
    unReadChatCount: 0,
  ),
  ChatRoom(
    chatRoomId: 6,
    isOnline: false,
    profilePhoto: "https://i.imgur.com/KpPiNC7.jpeg",
    nickname: "KpPiNC7",
    chat: [],
    pinToTop: false,
    unReadChatCount: 0,
  ),
  ChatRoom(
    chatRoomId: 7,
    isOnline: true,
    profilePhoto: "https://i.imgur.com/KpPiNC7.jpeg",
    nickname: "KpPiNC7",
    chat: [],
    pinToTop: false,
    unReadChatCount: 0,
  ),
  ChatRoom(
    chatRoomId: 8,
    isOnline: false,
    profilePhoto: "https://i.imgur.com/qrtX0cK.jpeg",
    nickname: "qrtX0cK",
    chat: [],
    pinToTop: false,
    unReadChatCount: 0,
  ),
  ChatRoom(
    chatRoomId: 9,
    isOnline: true,
    profilePhoto: "https://i.imgur.com/KpPiNC7.jpeg",
    nickname: "KpPiNC7",
    chat: [],
    pinToTop: false,
    unReadChatCount: 0,
  ),
];
