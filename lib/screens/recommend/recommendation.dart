import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:swipable_stack/swipable_stack.dart';
import 'package:wooyeon_flutter/service/recommend/recommend_service.dart';
import 'package:wooyeon_flutter/widgets/recommend/background_profile.dart';
import 'package:wooyeon_flutter/widgets/recommend/card_controller.dart';
import 'package:wooyeon_flutter/widgets/recommend/profile_info.dart';

import '../../config/palette.dart';
import '../../models/data/recommend_data.dart';
import '../../models/data/recommend_profile_model.dart';
import '../../widgets/recommend/card_overlay.dart';

class Recommendation extends StatefulWidget {
  final double bodyHeight;
  const Recommendation(this.bodyHeight, {super.key});

  @override
  State<Recommendation> createState() => _RecommendationState();
}

class _RecommendationState extends State<Recommendation> {
  List<RecommendProfileModel> recommendProfileList = [];
  bool isLoading = true;
  late final SwipableStackController controller;

  void _listenController() => setState(() {});
  void waitForRecommendProfileList() async{
    recommendProfileList = await RecommendService.getRecommendProfileList();
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // ToDo : fetch RecommendProfileList from API
    waitForRecommendProfileList();
    controller = SwipableStackController()..addListener(_listenController);
  }

  @override
  void dispose() {
    super.dispose();
    controller
      ..removeListener(_listenController)
      ..dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            height: widget.bodyHeight - 10,
            child: SwipableStack(
              itemCount: recommendProfiles.length,
              detectableSwipeDirections: const {
                SwipeDirection.right,
                SwipeDirection.left,
              },
              controller: controller,
              stackClipBehaviour: Clip.none,
              onSwipeCompleted: (index, direction) {
                // ToDo : swipe 완료 후, like 라면, 정보 API 로 전달
                // ToDo :
                dev.log('$index, $direction');
              },
              horizontalSwipeThreshold: 0.7,
              verticalSwipeThreshold: 0.7,
              allowVerticalSwipe: false,
              builder: (BuildContext context, properties) {
                final itemIndex = properties.index;// % recommendProfiles.length;

                return Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Palette.inactive,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        // ToDo : recommendProfileList data from API 로 변경
                        BackgroundProfile(recommendProfiles[itemIndex]),
                        ProfileInfo(recommendProfiles[itemIndex], controller),
                        CardController(controller),
                        if (properties.stackIndex == 0 &&
                            properties.direction != null)
                          CardOverlay(
                            swipeProgress: properties.swipeProgress,
                            direction: properties.direction!,
                          )
                      ],
                    ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
