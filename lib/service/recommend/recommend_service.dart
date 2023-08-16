import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:wooyeon_flutter/models/data/recommend_profile_model.dart';
import '../../config/config.dart';

class RecommendService {
  // ToDo : Url 설정
  static const String baseUrl = Config.domain;
  static const String recommendProfile = "recommand/profilelist";

  static Future<List<RecommendProfileModel>> getRecommendProfileList() async{
    List<RecommendProfileModel> recommendProfileInstances = [];

    final url = Uri.parse('$baseUrl/$recommendProfile');
    final response = await http.get(url);

    if(response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202 || response.statusCode == 204){
      final Map<String, dynamic> recommendProfileMap = jsonDecode(utf8.decode(response.bodyBytes));
      final List<dynamic> recommendProfileList = recommendProfileMap['content'];

      for(var recommendProfile in recommendProfileList){
        final instance = RecommendProfileModel.fromJsom(recommendProfile);
        recommendProfileInstances.add(instance);
        
        // log
        log("{");
        log("profileID : ${instance.profileId}");
        log("gender : ${instance.gender}");
        log("nickname : ${instance.nickname}");
        log("birthday : ${instance.birthday}");
        log("locationInfo : ${instance.locationInfo}");
        log("gpsLocationInfo : ${instance.gpsLocationInfo}");
        log("mbti : ${instance.mbti}");
        log("intro : ${instance.intro}");
        log("}");
      }
      return recommendProfileInstances;
    }
    throw Error();
  }
}