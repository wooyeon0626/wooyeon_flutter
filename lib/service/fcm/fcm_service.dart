import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../../config/config.dart';

class FcmService {
  static const String baseUrl = Config.domain;

  // POST 요청 : FCM Token
  static Future<void> postFcmToken({required String fcmToken}) async {
    final url = Uri.parse('$baseUrl/fcm/token');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'token': fcmToken,
      }),
    );

    if (response.statusCode >= 200 && response.statusCode <= 206) {
      log("Post FCM Token success");
      log(response.body);
    } else {
      log("Error with status code : ${response.statusCode}");
    }
  }
}
