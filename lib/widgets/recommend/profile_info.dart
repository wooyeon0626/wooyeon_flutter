import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:swipable_stack/swipable_stack.dart';
import 'package:wooyeon_flutter/utils/util.dart';

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
  // Todo : IOS 스타일 이상함 수정 필요.
  void showBottomSheet() {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (BuildContext context) {
        return RecommendationDetail(widget.profile, widget.controller);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: GestureDetector(
        onVerticalDragUpdate: (details) {
          if ((details.delta.dy.abs() > 8) & (details.delta.direction < 0)) {
            showBottomSheet();
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: IntrinsicHeight(
              child: Container(
                decoration: BoxDecoration(
                    color: Palette.black.withOpacity(0.75),
                    borderRadius: BorderRadius.circular(50)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: IconButton(
                        onPressed: () {
                          showBottomSheet();
                        },
                        icon: const Icon(
                          EvaIcons.arrowIosUpwardOutline,
                          size: 32,
                          color: Color(0x79FFFFFF),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (widget.profile.authenticatedAccount)
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: Icon(
                                EvaIcons.shield,
                                color: Palette.primary,
                              ),
                            ),
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
                              "${birthdayToAge(widget.profile.birthday)}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (widget.profile.intro != null)
                      IntrinsicHeight(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 40, right: 40, bottom: 20),
                          child: SizedBox(
                            child: Text(
                              widget.profile.intro ?? "",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              softWrap: true,
                            ),
                          ),
                        ),
                      )
                    else
                      const SizedBox(
                        height: 10,
                      ),
                    const SizedBox(
                      height: 72,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
