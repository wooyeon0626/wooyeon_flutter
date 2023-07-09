import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../screens/match/tab_bar/like_from.dart';
import '../../screens/match/tab_bar/like_to.dart';
import '../../screens/match/tab_bar/matched.dart';

class MatchTabBarState extends GetxController{
  final RxInt _selected = 0.obs;

  getInx() => _selected.value;
  setInx(val) => _selected.value = val;

  List<Widget> getWidgets() {
    return const [
      LikeFrom(),
      LikeTo(),
      Matched(),
    ];
  }
}