import 'package:flutter/material.dart';
import 'package:wooyeon_flutter/service/recommend/recommend_service.dart';
import 'package:wooyeon_flutter/widgets/match/like_to_profile.dart';
import '../../../models/data/recommend_profile_model.dart';

class LikeTo extends StatefulWidget {
  const LikeTo({super.key});

  @override
  State<LikeTo> createState() => _LikeToState();
}

class _LikeToState extends State<LikeTo> {
  List<RecommendProfileModel> likeToProfiles = dummyRecommendProfiles;

  // init likeToProfiles from API
  void initRecommendProfiles() async {
    likeToProfiles = await RecommendService.getLikeToList();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // ToDo : fetch RecommendProfileList from API
    //initRecommendProfiles();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Center(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2열로 표시
              childAspectRatio: 0.7),
          itemCount: likeToProfiles.length,
          itemBuilder: (context, gridIndex) {
            return Container(
              margin: EdgeInsets.all(3.0), // 여기서 마진을 설정합니다.
              child: LikeToProfile(likeToProfiles[gridIndex]),
            );
          },
        ),
      ),
    );
  }
}
