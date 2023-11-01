import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooyeon_flutter/screens/chat/chat.dart';
import 'package:wooyeon_flutter/screens/chat/chat_appbar.dart';
import 'package:wooyeon_flutter/screens/match/match.dart';
import 'package:wooyeon_flutter/screens/match/match_appbar.dart';
import 'package:wooyeon_flutter/screens/mypage/profile.dart';
import 'package:wooyeon_flutter/screens/recommend/recommendation_appbar.dart';
import '../../screens/lounge/lounge.dart';
import '../../screens/lounge/lounge_appbar.dart';
import '../../screens/recommend/recommendation.dart';

class NavigationBarState extends GetxController{
  final RxInt _selected = 0.obs;

  getInx() => _selected.value;
  setInx(val) => _selected.value = val;

  Widget getSelectedWidget(double bodyHeight) {
    switch (_selected.value) {
      case 0:
        return Recommendation(bodyHeight);
      case 1:
        return Lounge(bodyHeight);
      case 2:
        return Match(bodyHeight);
      case 3:
        return Chat(bodyHeight);
      case 4:
        return Profile(bodyHeight);
      default:
        return Recommendation(bodyHeight);
    }
  }

  Widget getSelectedAppbar() {
    switch (_selected.value) {
      case 0:
        return const RecommendationAppbar();
      case 1:
        return const LoungeAppbar();
      case 2:
        return const MatchAppbar();
      case 3:
        return const ChatAppbar();
      default:
        return const RecommendationAppbar();
    }
  }
}