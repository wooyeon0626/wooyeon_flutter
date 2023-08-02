import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:wooyeon_flutter/widgets/login/gender_picker.dart';
import 'package:wooyeon_flutter/widgets/login/profile_progressbar.dart';

import '../../../config/palette.dart';
import '../../../widgets/basic_textfield.dart';
import '../../../widgets/next_button.dart';

class RPGender extends StatelessWidget {
  RPGender({super.key});

  final buttonActive = ValueNotifier<bool>(true);
  final gender = ValueNotifier<String>("M");


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
              const ProfileProgressBar(start: 0.125, end: 0.25,),
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
                    letterSpacing: -2.5,),
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child:  GenderPicker(),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
                    child: ValueListenableBuilder<String>(
                        valueListenable: gender,
                        builder: (context, genderValue, child) {
                          // todo: 여기서 pref에 저장하기

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: NextButton(
                              //nextPage: ,
                                text: "다음",
                                isActive: buttonActive),
                          );
                        }
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