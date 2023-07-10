import 'package:flutter/material.dart';
import 'package:wooyeon_flutter/widgets/image_slider.dart';
import '../../models/data/recommend_data.dart';

class BackgroundProfile extends StatefulWidget {
  final RecommendProfiles profile;

  const BackgroundProfile(this.profile, {super.key});

  @override
  State<BackgroundProfile> createState() => _BackgroundProfile();
}

class _BackgroundProfile extends State<BackgroundProfile> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Align(
            alignment: Alignment.center,
            child: ImageSlider(
              images: widget.profile.profilePhoto,
              width: MediaQuery.of(context).size.width - 40,
              height: double.infinity,
            )));
  }
}
