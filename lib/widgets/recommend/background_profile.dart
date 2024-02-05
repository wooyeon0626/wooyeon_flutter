import 'package:flutter/material.dart';
import 'package:wooyeon_flutter/models/data/recommend_profile_model.dart';
import 'package:wooyeon_flutter/widgets/image_slider.dart';

class BackgroundProfile extends StatefulWidget {
  final RecommendProfileModel profile;

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
