import 'dart:developer';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart' as pin;
import 'package:wooyeon_flutter/models/pref.dart';
import 'package:wooyeon_flutter/screens/login/register_profile/rp_mbti.dart';
import 'package:wooyeon_flutter/widgets/login/profile_progressbar.dart';
import 'package:wooyeon_flutter/widgets/next_button_async.dart';

import '../../../config/palette.dart';
import '../../../utils/transition.dart';

class RPBirthday extends StatefulWidget {
  const RPBirthday({super.key});

  @override
  State<RPBirthday> createState() => _RPBirthdayState();
}

class _RPBirthdayState extends State<RPBirthday> {
  final buttonActive = ValueNotifier<bool>(false);
  final birthday = ValueNotifier<String>("");
  String? _birthday;

  late final String today;

  final RegExp birthdayValidator = RegExp(
    r'^\d{8}$',
  );

  @override
  void initState() {
    super.initState();
    _birthday = Pref.instance.profileData?.birthday;
    formattedDate();
  }

  void formattedDate() {
    DateTime now = DateTime.now();
    today = "${now.year}${_formatTwoDigits(now.month)}${_formatTwoDigits(now.day)}";
  }

  String _formatTwoDigits(int number) {
    return number.toString().padLeft(2, '0');
  }

  bool isValidDate(String date) {
    if (date.length != 8) return false;

    int year = int.tryParse(date.substring(0, 4)) ?? 0;
    int month = int.tryParse(date.substring(4, 6)) ?? 0;
    int day = int.tryParse(date.substring(6, 8)) ?? 0;

    if (year == 0 || month == 0 || day == 0) return false;

    DateTime? parsedDate;
    try {
      parsedDate = DateTime(year, month, day);
    } catch (e) {
      return false;
    }

    return parsedDate.year == year &&
        parsedDate.month == month &&
        parsedDate.day == day;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController textFieldController = TextEditingController();

    if (_birthday != null) {
      textFieldController.text = _birthday!;
      birthday.value = textFieldController.text;
      buttonActive.value =
          birthdayValidator.hasMatch(textFieldController.text) &&
              isValidDate(textFieldController.text);
    }

    textFieldController.addListener(() {
      birthday.value = textFieldController.text;
      buttonActive.value =
          birthdayValidator.hasMatch(textFieldController.text) &&
              isValidDate(textFieldController.text);
    });

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
                start: 0.25,
                end: 0.375,
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
                  "생일이 언제인가요?",
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
                  child: pin.PinInputTextField(
                    pinLength: 8,
                    decoration: pin.UnderlineDecoration(
                      colorBuilder: pin.PinListenColorBuilder(
                          Palette.primary, Palette.lightGrey),
                      gapSpaces: [8, 8, 8, 32, 8, 32, 8],
                      hintText: today,
                      hintTextStyle: const TextStyle(fontSize: 24, color: Palette.lightGrey),
                    ),
                    controller: textFieldController,
                    autoFocus: true,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      RegExp regExp = RegExp(r'^\d+$');
                      if (value.isNotEmpty && !regExp.hasMatch(value)) {
                        textFieldController.text = textFieldController.text
                            .substring(
                                0, textFieldController.text.length - 1);
                      }
                    },
                    cursor: pin.Cursor(
                        width: 2,
                        height: 30,
                        color: Palette.primary,
                        radius: const Radius.circular(1),
                        enabled: true,
                        orientation: pin.Orientation.vertical),
                    onSubmit: (pin) {
                      log('submit pin : $pin');
                    },
                  )),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 40, horizontal: 40),
                    child: ValueListenableBuilder<String>(
                        valueListenable: birthday,
                        builder: (context, birthdayValue, child) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Builder(
                              builder: (newContext) {
                                final ctx = newContext;

                                return NextButtonAsync(
                                    text: "다음",
                                    isActive: buttonActive,
                                    func: () async {
                                      Pref.instance.profileData?.birthday =
                                          birthdayValue;
                                      log(Pref.instance.profileData.toString());
                                      await Pref.instance.saveProfile();

                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        navigateHorizontally(
                                          context: ctx,
                                          widget: const RPMbti(),
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
