import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:wooyeon_flutter/config/palette.dart';
import 'package:wooyeon_flutter/models/data/recommend_profile_model.dart';
import 'package:wooyeon_flutter/widgets/match/like_to_profile_detail.dart';

class LikeToProfile extends StatefulWidget {
  final RecommendProfileModel profile;

  const LikeToProfile(this.profile, {super.key});

  @override
  State<LikeToProfile> createState() => _LikeToProfile();
}

class _LikeToProfile extends State<LikeToProfile> {
  final _controller = PageController(initialPage: 0);

  void showBottomSheet() {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (BuildContext context) {
        return LikeToProfileDetail(widget.profile);
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
            children: [
              Container(
                color: Palette.inactive,
                child: const Center(
                    child: Icon(
                  EvaIcons.image,
                  color: Colors.white,
                  size: 96,
                )),
              ),
              Image.network(
                widget.profile.profilePhoto[0],
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              PageView(
                controller: _controller,
                children: [
                  // 투명 컨테이너
                  Container(
                    decoration: BoxDecoration(
                      color: Palette.black.withOpacity(0),
                    ),
                  ),
                  // 상세 컨테이너
                  Container(
                    decoration: BoxDecoration(
                        color: Palette.black.withOpacity(0.75),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "상세 정보",
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
