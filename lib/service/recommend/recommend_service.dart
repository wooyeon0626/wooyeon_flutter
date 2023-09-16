import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:wooyeon_flutter/models/data/recommend_profile_model.dart';
import '../../config/config.dart';

class RecommendService {
  static const String baseUrl = Config.domain;

  // GET 요청 : recommendProfile List
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

  // POST 요청 : like to
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

  // GET 요청 : 내가 좋아요 한 사람들 리스트
  static Future<List<RecommendProfileModel>> getLikeToList() async {
    List<RecommendProfileModel> recommendProfileInstances = [];

    final url = Uri.parse('$baseUrl/like/to');
    final response = await http.get(url);

    if (response.statusCode >= 200 && response.statusCode <= 206) {
      /*
      final Map<String, dynamic> recommendProfileMap =
          jsonDecode(utf8.decode(response.bodyBytes));
      final List<dynamic> recommendProfileList = recommendProfileMap['content'];

      for (var recommendProfile in recommendProfileList) {
        final instance = RecommendProfileModel.fromJsom(recommendProfile);
        recommendProfileInstances.add(instance);
      }
      */
      return recommendProfileInstances;
    }
    throw Error();
  }

  // GET 요청 : 나를 좋아요 한 사람들 리스트
  static Future<List<RecommendProfileModel>> getLikeFromList() async {
    List<RecommendProfileModel> recommendProfileInstances = [];

    final url = Uri.parse('$baseUrl/like/from');
    final response = await http.get(url);

    if (response.statusCode >= 200 && response.statusCode <= 206) {
      /*
      final Map<String, dynamic> recommendProfileMap =
          jsonDecode(utf8.decode(response.bodyBytes));
      final List<dynamic> recommendProfileList = recommendProfileMap['content'];

      for (var recommendProfile in recommendProfileList) {
        final instance = RecommendProfileModel.fromJsom(recommendProfile);
        recommendProfileInstances.add(instance);
      }
      */
      return recommendProfileInstances;
    }
    throw Error();
  }

  // GET 요청 : 나와 매치된 사람들 리스트
  static Future<List<RecommendProfileModel>> getMatchedList() async {
    List<RecommendProfileModel> recommendProfileInstances = [];

    final url = Uri.parse('$baseUrl/like/matched');
    final response = await http.get(url);

    if (response.statusCode >= 200 && response.statusCode <= 206) {
      /*
      final Map<String, dynamic> recommendProfileMap =
          jsonDecode(utf8.decode(response.bodyBytes));
      final List<dynamic> recommendProfileList = recommendProfileMap['content'];

      for (var recommendProfile in recommendProfileList) {
        final instance = RecommendProfileModel.fromJsom(recommendProfile);
        recommendProfileInstances.add(instance);
      }
      */
      return recommendProfileInstances;
    }
    throw Error();
  }
}
