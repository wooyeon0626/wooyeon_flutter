import 'package:flutter/material.dart';
import 'package:wooyeon_flutter/widgets/match/like_to_profile.dart';
import '../../../models/data/recommend_profile_model.dart';

class LikeTo extends StatefulWidget {
  const LikeTo({super.key});

  @override
  State<LikeTo> createState() => _LikeToState();
}

class _LikeToState extends State<LikeTo> {
  List<RecommendProfileModel> likeFromProfiles = dummyRecommendProfiles;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Center(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2열로 표시
              childAspectRatio: 0.7),
          itemCount: likeFromProfiles.length,
          itemBuilder: (context, gridIndex) {
            return Container(
              margin: EdgeInsets.all(3.0), // 여기서 마진을 설정합니다.
              child: LikeToProfile(likeFromProfiles[gridIndex]),
            );
          },
        ),
      ),
    );
  }
}
