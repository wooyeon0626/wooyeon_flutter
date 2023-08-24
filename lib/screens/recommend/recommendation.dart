import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:swipable_stack/swipable_stack.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:wooyeon_flutter/service/recommend/recommend_service.dart';
import 'package:wooyeon_flutter/widgets/recommend/background_profile.dart';
import 'package:wooyeon_flutter/widgets/recommend/card_controller.dart';
import 'package:wooyeon_flutter/widgets/recommend/profile_info.dart';

import '../../config/palette.dart';
import '../../models/data/recommend_profile_model.dart';
import '../../widgets/recommend/card_overlay.dart';

class Recommendation extends StatefulWidget {
  final double bodyHeight;

  const Recommendation(this.bodyHeight, {super.key});

  @override
  State<Recommendation> createState() => _RecommendationState();
}

class _RecommendationState extends State<Recommendation> {
  bool isLoading = false;
  late final SwipableStackController controller;

  void _listenController() => setState(() {});

  /*
  List<RecommendProfileModel> recommendProfileList = [];
  void waitForRecommendProfileList() async {
    recommendProfileList = await RecommendService.getRecommendProfileList();
    isLoading = false;
    setState(() {});
  }
   */

  @override
  void initState() {
    super.initState();
    // ToDo : fetch RecommendProfileList from API
    //waitForRecommendProfileList();
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
            child: isLoading
                ? Center(
                    child: LoadingAnimationWidget.fourRotatingDots(
                        color: Palette.primary, size: 40), // 로딩 애니메이션
                  )
                : SwipableStack(
                    itemCount: recommendProfiles.length,
                    detectableSwipeDirections: const {
                      SwipeDirection.right,
                      SwipeDirection.left,
                    },
                    controller: controller,
                    stackClipBehaviour: Clip.none,
                    onSwipeCompleted: (index, direction) async {
                      dev.log('$index, $direction');

                      // 마지막 카드가 swipe 되면, 로딩 상태로 변경 후 데이터 fetch
                      if (index == recommendProfiles.length - 1) {
                        setState(() {
                          isLoading = true;
                        });
                        final newRecommendProfiles =
                            await RecommendService.getRecommendProfileList();
                        recommendProfiles.addAll(newRecommendProfiles);
                        setState(() {
                          isLoading = false;
                        });
                      }

                      // 오른쪽 swipe == 좋아요
                      if (direction == SwipeDirection.right) {
                        // ToDo : swipe 완료 후, like 라면, 정보 API 로 전달
                        final toUserId = recommendProfiles[index].userId;
                        dev.log(
                            'RecommendService.postLikeTo(toUserId: $toUserId);');
                      }
                    },
                    horizontalSwipeThreshold: 0.7,
                    verticalSwipeThreshold: 0.7,
                    allowVerticalSwipe: false,
                    builder: (BuildContext context, properties) {
                      final itemIndex =
                          properties.index; // % recommendProfiles.length;

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
                            ProfileInfo(
                                recommendProfiles[itemIndex], controller),
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
