import 'dart:developer';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:wooyeon_flutter/widgets/login/profile_progressbar.dart';

import '../../../config/palette.dart';
import '../../../models/pref.dart';
import '../../../utils/transition.dart';
import '../../../widgets/next_button_async.dart';
import '../login.dart';

class RPImage extends StatefulWidget {
  const RPImage({super.key});

  @override
  State<RPImage> createState() => _RPImageState();
}

class _RPImageState extends State<RPImage> {
  final buttonActive = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
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
                start: 0.875,
                end: 1,
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
                  "사진을 추가해주세요",
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
                                log(Pref.instance.profileData.toString());
                                await Pref.instance.saveProfile();

                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  navigateHorizontally(
                                    context: ctx,
                                    widget: const Login(),
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
