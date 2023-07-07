import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:swipable_stack/swipable_stack.dart';

import '../../config/palette.dart';
import '../../models/data/recommend_data.dart';
import '../../screens/recommend/recommendation_detail.dart';

class ProfileInfo extends StatefulWidget {
  final RecommendProfiles profile;
  final SwipableStackController controller;

  const ProfileInfo(this.profile, this.controller, {super.key});

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {

  void showBottomSheet() {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (BuildContext context) {
        return RecommendationDetail(widget.profile);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.delta.dy.abs() > 8) {
            showBottomSheet();
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                  color: Palette.black.withOpacity(0.75),
                  borderRadius: BorderRadius.circular(50)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.profile.nickname,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            ": ${widget.profile.birthday}",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 220,
                    child: Text(
                      widget.profile.intro ?? "",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      softWrap: true,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: IconButton(
                              onPressed: () {
                                widget.controller
                                    .next(swipeDirection: SwipeDirection.left);
                              },
                              icon: const Icon(
                                EvaIcons.closeCircle,
                                color: Palette.red,
                              ),
                              iconSize: 64,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: IconButton(
                              onPressed: () {
                                widget.controller.rewind();
                              },
                              icon: const Icon(
                                EvaIcons.arrowCircleLeft,
                                color: Palette.yellow,
                              ),
                              iconSize: 64,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: IconButton(
                              onPressed: () {
                                widget.controller
                                    .next(swipeDirection: SwipeDirection.right);
                              },
                              icon: const Icon(
                                EvaIcons.checkmarkCircle2,
                                color: Palette.green,
                              ),
                              iconSize: 64,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
