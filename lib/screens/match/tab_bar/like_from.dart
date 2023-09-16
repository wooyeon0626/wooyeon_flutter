import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:swipable_stack/swipable_stack.dart';
import 'package:wooyeon_flutter/models/data/recommend_profile_model.dart';
import 'package:wooyeon_flutter/widgets/match/like_from_profile.dart';
import 'package:wooyeon_flutter/widgets/recommend/card_overlay.dart';

class LikeFrom extends StatefulWidget {
  const LikeFrom({Key? key});

  @override
  State<LikeFrom> createState() => _LikeFromState();
}

class _LikeFromState extends State<LikeFrom> {
  List<RecommendProfileModel> likeFromProfiles = dummyRecommendProfiles;

  void removeItem(int index) {
    setState(() {
      likeFromProfiles.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2열로 표시
          childAspectRatio: 0.7,
        ),
        itemCount: likeFromProfiles.length,
        itemBuilder: (context, gridIndex) {
          return AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            child: Padding(
              key: ValueKey<String>(likeFromProfiles[gridIndex].userCode),
              // 고유한 키를 지정
              padding: const EdgeInsets.all(3.0),
              child: SwipableStack(
                itemCount: 1,
                // SwipableStack 내에 1개의 카드만 있도록 설정
                detectableSwipeDirections: const {
                  SwipeDirection.right,
                  SwipeDirection.left,
                },
                onSwipeCompleted: (swipedIndex, direction) async {
                  // Swipe 완료 후, like 라면 (오른쪽 swipe == 좋아요) like 정보 post
                  if (direction == SwipeDirection.right) {
                    final toUserCode = likeFromProfiles[swipedIndex].userCode;
                    // ToDo: Like 정보 API로 전달
                    log("RecommendService.postLikeTo(toUserCode: $toUserCode);");
                    // RecommendService.postLikeTo(toUserCode: toUserCode);
                  }

                  removeItem(gridIndex);
                },
                horizontalSwipeThreshold: 0.7,
                swipeAnchor: SwipeAnchor.bottom,
                allowVerticalSwipe: false,
                builder: (BuildContext context, properties) {
                  return Stack(children: [
                    LikeFromProfile(likeFromProfiles[gridIndex]),
                    if (properties.stackIndex == 0 &&
                        properties.direction != null)
                      CardOverlay(
                        swipeProgress: properties.swipeProgress,
                        direction: properties.direction!,
                      )
                  ]);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
