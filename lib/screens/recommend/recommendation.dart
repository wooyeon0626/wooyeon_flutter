import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:swipable_stack/swipable_stack.dart';
import 'package:wooyeon_flutter/screens/recommend/recommendation_detail.dart';
import 'package:wooyeon_flutter/widgets/recommend/background_profile.dart';
import 'package:wooyeon_flutter/widgets/recommend/profile_info.dart';

import '../../config/palette.dart';
import '../../models/data/recommend_data.dart';
import '../../widgets/recommend/card_overlay.dart';

class Recommendation extends StatefulWidget {
  const Recommendation({super.key});

  @override
  State<Recommendation> createState() => _RecommendationState();
}

class _RecommendationState extends State<Recommendation> {
  late final SwipableStackController controller;

  void _listenController() => setState(() {});

  @override
  void initState() {
    super.initState();
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
    final appBarHeight = AppBar().preferredSize.height;
    const bottomNavigationBarHeight = 80;

    final screenHeight = appBarHeight + bottomNavigationBarHeight + 50;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height - screenHeight,
          child: SwipableStack(
            detectableSwipeDirections: const {
              SwipeDirection.right,
              SwipeDirection.left,
            },
            controller: controller,
            stackClipBehaviour: Clip.none,
            onSwipeCompleted: (index, direction) {
              dev.log('$index, $direction');
            },
            horizontalSwipeThreshold: 0.7,
            verticalSwipeThreshold: 0.7,
            allowVerticalSwipe: false,
            builder: (BuildContext context, properties) {
              final itemIndex = properties.index % recommendProfiles.length;

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
                      BackgroundProfile(recommendProfiles[itemIndex]),
                      ProfileInfo(recommendProfiles[itemIndex], controller),
                      if (properties.stackIndex == 0 &&
                          properties.direction != null)
                        CardOverlay(
                          swipeProgress: properties.swipeProgress,
                          direction: properties.direction!,
                        )
                    ],
                  ));
            },
          ),
        ),
      ],
    );
  }
}
