import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../config/config.dart';
import '../../models/data/chat_data.dart';
import '../../models/data/chat_room_data.dart';

class ChatService {
  static const String baseUrl = Config.domain;

  // GET 요청 : ChatRoom List
  static Future<Map<int, ChatRoom>> getChatRoomList() async {
    Map<int, ChatRoom> chatRoomMap = {};

    // Todo : url 확인
    final url = Uri.parse('$baseUrl/chat/chatRoomList');
    final response = await http.get(url);

    if (response.statusCode >= 200 && response.statusCode <= 206) {
      final Map<String, dynamic> responseMap =
      jsonDecode(utf8.decode(response.bodyBytes));
      final List<dynamic> chatRoomList = responseMap['chatRoomList'];

      for (var chatRoom in chatRoomList) {
        final instance = ChatRoom.fromJson(chatRoom);
        chatRoomMap[instance.chatRoomId] = instance;
      }
      return chatRoomMap;
    }
    throw Error();
  }

  // GET 요청 : 특정 채팅방의 ChatData
  static Future<List<ChatData>> getChatData(int chatRoomId) async {
    List<ChatData> chatDataList = [];

    // Todo : url 확인
    final url = Uri.parse('$baseUrl/chat/$chatRoomId/chatData');
    final response = await http.get(url);

    if (response.statusCode >= 200 && response.statusCode <= 206) {
      final Map<String, dynamic> responseMap =
      jsonDecode(utf8.decode(response.bodyBytes));
      final List<dynamic> chatList = responseMap['chatData'];

      for (var chat in chatList) {
        final instance = ChatData.fromJson(chat);
        chatDataList.add(instance);
      }
      return chatDataList;
    }
    throw Error();
  }

}
