import 'dart:developer';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:wooyeon_flutter/models/pref.dart';
import 'package:wooyeon_flutter/screens/login/register_profile/rp_hobby.dart';
import 'package:wooyeon_flutter/widgets/login/profile_progressbar.dart';
import 'package:wooyeon_flutter/widgets/next_button_async.dart';

import '../../../config/palette.dart';
import '../../../utils/transition.dart';

class RPIntro extends StatefulWidget {
  const RPIntro({super.key});

  @override
  State<RPIntro> createState() => _RPIntroState();
}

class _RPIntroState extends State<RPIntro> {
  TextEditingController textFieldController = TextEditingController();
  final buttonActive = ValueNotifier<bool>(true);
  int currentLength = 0;
  late String _lastValidInput;
  late int _cursorPosition;
  String? _intro;

  @override
  void initState() {
    super.initState();
    _intro = Pref.instance.profileData?.intro;
    if (_intro != null) {
      textFieldController.text = _intro!;
      currentLength = _intro!.length;
    }
    _lastValidInput = "";
    _cursorPosition = 0;
  }

  bool _isValid(String value) {
    final regExp = RegExp(r'^(?:[^\n]*\n){0,4}[^\n]*$');
    return regExp.hasMatch(value);
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
                start: 0.5,
                end: 0.625,
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
                              Pref.instance.profileData?.intro = null;
                              await Pref.instance.saveProfile();

                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                navigateHorizontally(
                                  context: ctx,
                                  widget: const RPHobby(),
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
                  "자기소개를 해주세요",
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
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Palette.secondary,
                      width: 2,
                    ),
                  ),
                  child: Stack(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        autofocus: true,
                        controller: textFieldController,
                        maxLength: 100,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          hintText: '자기소개를 입력해주세요.',
                          border: InputBorder.none,
                          counterText: '',
                        ),
                        onChanged: (text) {
                          if (_isValid(text)) {
                            _lastValidInput = text;
                            _cursorPosition = textFieldController.selection.start;
                          } else {
                            textFieldController.text = _lastValidInput;
                            textFieldController.selection = TextSelection.fromPosition(
                                TextPosition(offset: _cursorPosition));
                          }
                          setState(() {
                            currentLength = text.length;
                          });
                        },
                      ),
                    ),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('$currentLength/100', style: const TextStyle(fontSize: 12, color: Palette.grey),),
                        ))
                  ]),
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
                                Pref.instance.profileData?.intro =
                                    textFieldController.text;
                                log(Pref.instance.profileData.toString());
                                await Pref.instance.saveProfile();

                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  navigateHorizontally(
                                    context: ctx,
                                    widget: const RPHobby(),
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
