import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:wooyeon_flutter/utils/jwt_utils.dart';
import '../../config/config.dart';
import '../../models/data/chat_data.dart';
import '../../models/data/chat_room_data.dart';

class ChatService {
  static const String baseUrl = Config.domain;

  // GET 요청 : ChatRoom List
  static Future<Map<int, ChatRoom>> getChatRoomList() async {
    Map<int, ChatRoom> chatRoomMap = {};

    final url = Uri.parse('$baseUrl/room/list');
    final response = await jwtGetRequest(url: url);
    if (response == null) {
      log('getChatRoomList() : response == null 에러 발생');
      throw Error();
    }

    debugPrint(
        'getChatRoomList() response : ${jsonDecode(utf8.decode(response.bodyBytes)).toString()}');
    final Map<String, dynamic> responseMap =
        jsonDecode(utf8.decode(response.bodyBytes));
    final List<dynamic> chatRoomList = responseMap['chatRoomList'];

    for (var chatRoom in chatRoomList) {
      final instance = ChatRoom.fromJson(chatRoom);
      chatRoomMap[instance.chatRoomId] = instance;
    }
    return chatRoomMap;
  }

  // GET 요청 : 특정 채팅방의 ChatData
  static Future<List<ChatData>> getChatData(int chatRoomId) async {
    List<ChatData> chatDataList = [];

    final url = Uri.parse('$baseUrl/chat/list?matchId=$chatRoomId');
    final response = await jwtGetRequest(url: url);
    if (response == null) {
      log('getChatData() : response == null 에러 발생');
      throw Error();
    }

    debugPrint(
        'getChatData() response : ${jsonDecode(utf8.decode(response.bodyBytes)).toString()}');
    final Map<String, dynamic> responseMap =
        jsonDecode(utf8.decode(response.bodyBytes));
    final List<dynamic> chatList = responseMap['chatData'];

    for (var chat in chatList) {
      final instance = ChatData.fromJson(chat);
      chatDataList.add(instance);
    }
    return chatDataList;
  }

  // POST 요청 : 특정 채팅방의 pinToTop toggle
  // Todo : url 확인, body에 뭐가 들어가야 하나요?, 테스트 필요
  static Future<void> togglePinToTop(int chatRoomId) async {
    final url = Uri.parse('$baseUrl/chat/list?matchId=$chatRoomId');
    final response = await jwtPostRequest(
      url: url,
      body: <String, String>{},
    );

    if (response == null) {
      log('togglePinToTop() : response == null 에러 발생');
      throw Error();
    }

    debugPrint(
        'togglePinToTop() response : ${jsonDecode(utf8.decode(response.bodyBytes)).toString()}');
  }
}
