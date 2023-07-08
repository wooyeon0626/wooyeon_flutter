import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:wooyeon_flutter/utils/util.dart';

import '../../config/palette.dart';
import '../../models/data/recommend_data.dart';
import '../../widgets/image_slider.dart';

class RecommendationDetail extends StatelessWidget {
  final RecommendProfiles profile;

  const RecommendationDetail(this.profile, {super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(
                height: 500,
                child: Stack(children: [
                  ImageSlider(
                    images: profile.profilePhoto,
                    width: MediaQuery.of(context).size.width,
                    height: 450,
                  ),
                  Positioned(
                      child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 80,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          child: Row(
                            children: [
                              Text(
                                profile.nickname,
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                // Todo : Birthday 대신 나이 넣기
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  "${birthdayToAge(profile.birthday)}",
                                  style: const TextStyle(
                                    fontSize: 28,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )),
                  Positioned(
                      child: Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 30, bottom: 0),
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          EvaIcons.arrowCircleDown,
                          color: Palette.primary,
                        ),
                        iconSize: 48,
                      ),
                    ),
                  )),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  children: [
                    Text(
                      "${profile.locationInfo},",
                      style: const TextStyle(
                        color: Palette.grey,
                        fontSize: 18,
                      ),
                    ),
                    const Padding(
                      // Todo : Distance 넣기
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "2km",
                        style: TextStyle(
                          color: Palette.grey,
                          fontSize: 18,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                child: Divider(thickness: 1.5, color: Palette.inactive,),
              ),
            ],
          )),
    );
  }
}
