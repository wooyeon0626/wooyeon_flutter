import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooyeon_flutter/screens/chat/chat.dart';
import 'package:wooyeon_flutter/screens/match/match.dart';
import 'package:wooyeon_flutter/screens/mypage/profile.dart';
import 'package:wooyeon_flutter/screens/recommend/recommendation_appbar.dart';
import 'package:wooyeon_flutter/screens/rounge/rounge.dart';

import '../../screens/recommend/recommendation.dart';

class NavigationBarState extends GetxController{
  final RxInt _selected = 0.obs;

  getInx() => _selected.value;
  setInx(val) => _selected.value = val;

  Widget getSelectedWidget() {
    switch (_selected.value) {
      case 0:
        return const Recommendation();
      case 1:
        return const Rounge();
      case 2:
        return const Match();
      case 3:
        return const Chat();
      case 4:
        return const Profile();
      default:
        return const Recommendation();
    }
  }

  Widget getSelectedAppbar() {
    switch (_selected.value) {
      case 0:
        return const RecommendationAppbar();
      default:
        return const RecommendationAppbar();
    }
  }
}