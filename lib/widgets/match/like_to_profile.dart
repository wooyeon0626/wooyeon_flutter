import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:wooyeon_flutter/config/palette.dart';
import 'package:wooyeon_flutter/models/data/recommend_profile_model.dart';
import 'package:wooyeon_flutter/utils/util.dart';
import 'package:wooyeon_flutter/widgets/match/like_to_profile_detail.dart';

class LikeToProfile extends StatefulWidget {
  final RecommendProfileModel profile;

  const LikeToProfile(this.profile, {super.key});

  @override
  State<LikeToProfile> createState() => _LikeToProfile();
}

class _LikeToProfile extends State<LikeToProfile> {
  final _controller = PageController(initialPage: 0);
  int _currentIndex = 0;

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

  List<Widget> _buildIndicators(BuildContext context) {
    final double totalIndicatorSize =
        MediaQuery.of(context).size.width / 2 - 24;
    final double indicatorSize =
        totalIndicatorSize / (widget.profile.profilePhoto.length + 1) - 4;

    if (widget.profile.profilePhoto.length < 2) {
      return [];
    }

    return List<Widget>.generate(widget.profile.profilePhoto.length, (index) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 2),
        width: index == _currentIndex ? indicatorSize * 2 : indicatorSize,
        height: 3.5,
        decoration: BoxDecoration(
          color: index == _currentIndex
              ? Colors.white
              : Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(2),
        ),
      );
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // PageController의 페이지 변경을 감지하고 처리
    _controller.addListener(() {
      // 현재 페이지 인덱스 가져오기
      final int newPageIndex = _controller.page?.round() ?? 0;

      // 현재 페이지 인덱스가 바뀌면 로그로 출력
      if (_currentIndex != newPageIndex) {
        setState(() {
          _currentIndex = newPageIndex;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                ),
              ),
            ),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                PageView(
                  controller: _controller,
                  children: [
                    for (var i = 0; i < widget.profile.profilePhoto.length; i++)
                      Image.network(
                        widget.profile.profilePhoto[i],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                  ],
                ),
                Positioned(
                  top: 13,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildIndicators(context),
                  ),
                ),
                IgnorePointer(
                  child: Container(
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
