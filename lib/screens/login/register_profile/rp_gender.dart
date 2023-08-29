import 'dart:developer';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:wooyeon_flutter/screens/login/register_profile/rp_birthday.dart';
import 'package:wooyeon_flutter/widgets/login/gender_picker.dart';
import 'package:wooyeon_flutter/widgets/login/profile_progressbar.dart';

import '../../../config/palette.dart';
import '../../../models/pref.dart';
import '../../../utils/transition.dart';
import '../../../widgets/next_button_async.dart';

class RPGender extends StatefulWidget {
  const RPGender({super.key});

  @override
  State<RPGender> createState() => _RPGenderState();
}

class _RPGenderState extends State<RPGender> {
  final buttonActive = ValueNotifier<bool>(true);
  final gender = ValueNotifier<String>("M");
  String? _gender;

  @override
  void initState() {
    super.initState();
    _gender = Pref.instance.profileData?.gender;
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
                start: 0.125,
                end: 0.25,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12, top: 25, bottom: 25),
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
                  "성별은 무엇인가요?",
                  style: TextStyle(
                      color: Palette.black,
                      fontSize: 32,
                      letterSpacing: -2.5,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: GenderPicker(
                  initGender:
                      _gender == null ? true : (_gender == 'F' ? false : true),
                  onGenderChanged: (bool newGender) {
                    if (newGender) {
                      Pref.instance.profileData?.gender = 'M';
                    } else {
                      Pref.instance.profileData?.gender = 'F';
                    }
                  },
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 40, horizontal: 40),
                    child: ValueListenableBuilder<String>(
                        valueListenable: gender,
                        builder: (context, genderValue, child) {
                          // todo: 여기서 pref에 저장하기

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Builder(
                              builder: (newContext) {
                                final ctx = newContext;

                                return NextButtonAsync(
                                    text: "다음",
                                    isActive: buttonActive,
                                    func: () async {
                                      log(Pref.instance.profileData.toString());
                                      await Pref.instance.saveProfile();

                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        navigateHorizontally(
                                          context: ctx,
                                          widget: const RPBirthday(),
                                        );
                                      });
                                    });
                              },
                            ),
                          );
                        }),
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
