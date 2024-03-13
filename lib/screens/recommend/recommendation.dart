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
  List<RecommendProfileModel> recommendProfiles = [
    RecommendProfileModel(userCode: 'testuser', gender: 'M', nickname: '우연', birthday: '20000101', locationInfo: 'LOC', gpsLocationInfo: 'GPS', authenticatedAccount: true, profilePhoto: ['https://i.imgur.com/saNUcyy.png'], intro: '우연 어플리케이션 테스트 프로필입니다.')
  ];
  bool isLoading = true;
  int swipedIndex = -1;
  late final SwipableStackController controller;

  void _listenController() => setState(() {});

  // init recommendProfiles from API
  void initRecommendProfiles() async {
    //recommendProfiles = await RecommendService.getRecommendProfileList();
    isLoading = false;
    setState(() {});
  }

  // add recommendProfiles with Redundancy checking
  void addRecommendProfiles() async {
    // fetch 새로운 recommendProfiles from API
    final newRecommendProfiles =
        await RecommendService.getRecommendProfileList();

    // 기존의 recommendProfiles 를 'userCode' 속성을 기준으로 정렬
    final existingRecommendProfiles = recommendProfiles;
    existingRecommendProfiles.sort((a, b) => a.userCode.compareTo(b.userCode));

    for (var newRecommendProfile in newRecommendProfiles) {
      // 이진 검색을 수행
      int left = 0;
      int right = existingRecommendProfiles.length - 1;
      RecommendProfileModel? foundObject;

      while (left <= right) {
        int mid = (left + right) ~/ 2;
        int compareResult = existingRecommendProfiles[mid]
            .userCode
            .compareTo(newRecommendProfile.userCode);

        if (compareResult == 0) {
          foundObject = existingRecommendProfiles[mid]; // 일치하는 요소를 찾았음
          break;
        } else if (compareResult < 0) {
          left = mid + 1; // 중간 요소보다 큰 부분에서 검색
        } else {
          right = mid - 1; // 중간 요소보다 작은 부분에서 검색
        }
      }

      if (foundObject != null) {
        dev.log("중복된 프로필 입니다 : ${foundObject.userCode}");
      } else {
        dev.log("중복된 프로필이 아닙니다. recommendProfiles 에 추가!");
        recommendProfiles.add(newRecommendProfile);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    // ToDo : fetch RecommendProfileList from API
    initRecommendProfiles();
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
                : (swipedIndex == recommendProfiles.length - 1)
                    ? Center(child: Text("추천 정보가 없어요...")) // Todo : UI 꾸미기
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
                          swipedIndex = index;

                          // swipe 완료 후, like 라면 (오른쪽 swipe == 좋아요) like 정보 post
                          if (direction == SwipeDirection.right) {
                            final toUserCode =
                                recommendProfiles[index].userCode;
                            dev.log(
                                'RecommendService.postLikeTo(toUserId: $toUserCode);');
                            // ToDo : Like 정보 API 로 전달
                            //RecommendService.postLikeTo(toUserCode: toUserCode);
                          }

                          // 마지막 카드가 swipe 되면, 로딩 상태로 변경 후 데이터 fetch
                          if (index == recommendProfiles.length - 1) {
                            setState(() {
                              isLoading = true;
                            });
                            // add recommendProfiles with Redundancy checking
                            addRecommendProfiles();
                            // 데이터 fetch 완료 후, 로딩 종료
                            setState(() {
                              isLoading = false;
                            });
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
