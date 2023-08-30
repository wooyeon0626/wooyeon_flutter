import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:wooyeon_flutter/models/data/recommend_profile_model.dart';
import '../../config/config.dart';

class RecommendService {
  // ToDo : Url 설정
  static const String baseUrl = Config.domain;

  static Future<List<RecommendProfileModel>> getRecommendProfileList() async {
    List<RecommendProfileModel> recommendProfileInstances = [];

    final url = Uri.parse('$baseUrl/recommand/profilelist');
    final response = await http.get(url);

    if (response.statusCode >= 200 && response.statusCode <= 206) {
      final Map<String, dynamic> recommendProfileMap =
          jsonDecode(utf8.decode(response.bodyBytes));
      final List<dynamic> recommendProfileList = recommendProfileMap['content'];

      for (var recommendProfile in recommendProfileList) {
        final instance = RecommendProfileModel.fromJsom(recommendProfile);
        recommendProfileInstances.add(instance);
      }
      return recommendProfileInstances;
    }
    throw Error();
  }

  static Future<void> postLikeTo({required String toUserCode}) async {
    final url = Uri.parse('$baseUrl/like/user');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        // ToDo : 현재 로그인 된 사용자의 UUID 가져오기
        //'likeFromUserUUID': "현재 로그인 된 사용자의 UUID",
        // 우선은, 1번 유저의 UUID
        'likeFromUserUUID': "484501f9-783e-44de-abbd-6516c0d15cc8",
        'likeToUserUUID': toUserCode,
      }),
    );

    if (response.statusCode >= 200 && response.statusCode <= 206) {
      log("Post like success");
      log(response.body);
    } else {
      log("Error with status code : ${response.statusCode}");
    }
  }
}
