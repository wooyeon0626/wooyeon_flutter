import 'dart:developer';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:wooyeon_flutter/models/pref.dart';
import 'package:wooyeon_flutter/screens/login/register_profile/rp_gender.dart';
import 'package:wooyeon_flutter/screens/login/register_profile/rp_introduce.dart';
import 'package:wooyeon_flutter/widgets/login/mbti_picker.dart';
import 'package:wooyeon_flutter/widgets/login/profile_progressbar.dart';
import 'package:wooyeon_flutter/widgets/next_button_async.dart';

import '../../../config/palette.dart';
import '../../../utils/transition.dart';

class RPMbti extends StatefulWidget {
  const RPMbti({super.key});

  @override
  State<RPMbti> createState() => _RPMbtiState();
}

class _RPMbtiState extends State<RPMbti> {
  final buttonActive = ValueNotifier<bool>(true);
  String? _mbti;

  @override
  void initState() {
    super.initState();
    _mbti = Pref.instance.profileData?.mbti;
    if(_mbti == '') _mbti = 'ENFJ';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          height: double.infinity,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProfileProgressBar(
                start: 0.375,
                end: 0.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 12, top: 25, bottom: 25),
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        EvaIcons.arrowIosBack,
                        color: Palette.black,
                      ),
                      iconSize: 40,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Builder(
                      builder: (newContext) {
                        final ctx = newContext;

                        return InkWell(
                          onTap: () async {
                            Pref.instance.profileData?.mbti = null;
                            await Pref.instance.saveProfile();

                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              navigateHorizontally(
                                context: ctx,
                                widget: const RPIntro(),
                              );
                            });
                          },
                          child: const Text(
                            "건너뛰기",
                            style: TextStyle(
                                color: Palette.secondary,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        );
                      }
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "당신을 알아가는 시간을 가져볼게요.",
                  style: TextStyle(
                    color: Palette.primary,
                    fontSize: 18,
                    letterSpacing: -2.5,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "MBTI를 알려주세요",
                  style: TextStyle(
                      color: Palette.black,
                      fontSize: 32,
                      letterSpacing: -2.5,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: MBTIPicker(
                  onChanged: (mbti) {
                    _mbti = mbti;
                  },
                  initMBTI: _mbti ?? 'ENFJ',
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20, left: 40, right: 40),
                child: Text(
                  "위/아래로 스크롤하여 각 MBTI 항목을 변경할 수 있어요.",
                  style: TextStyle(
                    color: Palette.grey,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 40, horizontal: 40),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Builder(
                        builder: (newContext) {
                          final ctx = newContext;

                          return NextButtonAsync(
                              text: "다음",
                              isActive: buttonActive,
                              func: () async {
                                Pref.instance.profileData?.mbti = _mbti;
                                log(_mbti ?? 'NULL');
                                await Pref.instance.saveProfile();

                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  navigateHorizontally(
                                    context: ctx,
                                    widget: const RPIntro(),
                                  );
                                });
                              });
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
