import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wooyeon_flutter/models/data/recommend_profile_model.dart';
import '../../config/config.dart';

class RecommendService {
  // ToDo : Url 설정
  static const String baseUrl = Config.domain;
  static const String recommendProfile = "";

  static Future<List<RecommendProfileModel>> getRecommendProfileList() async{
    List<RecommendProfileModel> recommendProfileInstances = [];

    final url = Uri.parse('$baseUrl/$recommendProfile');
    final response = await http.get(url);

    if(response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202 || response.statusCode == 204){
      final List<dynamic> recommendProfileList = jsonDecode(response.body);
      for(var recommendProfile in recommendProfileList){
        final instance = RecommendProfileModel.fromJsom(recommendProfile);
        recommendProfileInstances.add(instance);
      }
      return recommendProfileInstances;
    }
    throw Error();
  }
}