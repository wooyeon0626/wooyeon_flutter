import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:swipable_stack/swipable_stack.dart';
import 'package:wooyeon_flutter/config/palette.dart';
import 'package:wooyeon_flutter/models/data/recommend_profile_model.dart';
import 'package:wooyeon_flutter/screens/recommend/recommendation_detail.dart';
import 'package:wooyeon_flutter/utils/util.dart';

class LikeFromProfile extends StatefulWidget {
  final RecommendProfileModel profile;
  final SwipableStackController controller;

  const LikeFromProfile(this.profile, this.controller, {super.key});

  @override
  State<LikeFromProfile> createState() => _LikeFromProfile();
}

class _LikeFromProfile extends State<LikeFromProfile> {
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: GestureDetector(
        onTap: () {
          showBottomSheet();
        },
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              color: Palette.inactive,
              child: const Center(
                child: Icon(
                  EvaIcons.image,
                  color: Colors.white,
                  size: 96,
                ),
              ),
            ),
            Image.network(
              widget.profile.profilePhoto[0],
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Palette.black, Palette.black.withOpacity(0)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // 가로 정렬 설정
                  mainAxisAlignment: MainAxisAlignment.end,
                  // 세로 정렬 설정
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // 가로 정렬 설정
                      children: [
                        Text(
                          "${widget.profile.nickname},",
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            "${birthdayToAge(widget.profile.birthday)}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                        ),
                        if (widget.profile.authenticatedAccount)
                          const Padding(
                            padding: EdgeInsets.only(left: 2),
                            child: Icon(
                              EvaIcons.shield,
                              color: Palette.primary,
                              size: 18, // 아이콘 크기 조절
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      widget.profile.locationInfo,
                      style: const TextStyle(
                          color: Colors.white, fontSize: 15),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
