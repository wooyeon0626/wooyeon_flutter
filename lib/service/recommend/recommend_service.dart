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

  static Future<void> postLikeTo({required String toUserId}) async {
    //final url = Uri.parse('$baseUrl/like/user/$toUserId');
    final url = Uri.parse('/like/user/$toUserId');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        // ToDo : 현재 로그인 된 사용자의 userId 가져오기
        'fromUserId': "현재 로그인 된 사용자의 userId",
        'toUserId': toUserId,
      }),
    );

    if (response.statusCode >= 200 && response.statusCode <= 206) {
      log("Post like success");
    } else {
      log("Error with status code : ${response.statusCode}");
    }
  }
}
