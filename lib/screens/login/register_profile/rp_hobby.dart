import 'dart:developer';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'package:wooyeon_flutter/models/pref.dart';
import 'package:wooyeon_flutter/screens/login/register_profile/rp_gender.dart';
import 'package:wooyeon_flutter/screens/login/register_profile/rp_interest.dart';
import 'package:wooyeon_flutter/widgets/login/profile_progressbar.dart';
import 'package:wooyeon_flutter/widgets/next_button_async.dart';
import 'package:wooyeon_flutter/widgets/tag_item.dart';

import '../../../config/palette.dart';
import '../../../utils/transition.dart';

class RPHobby extends StatefulWidget {
  const RPHobby({super.key});

  @override
  State<RPHobby> createState() => _RPHobbyState();
}

class _RPHobbyState extends State<RPHobby> {
  final TextfieldTagsController _controller = TextfieldTagsController();
  final buttonActive = ValueNotifier<bool>(false);
  late double _distanceToField;
  List<String>? _hobby;
  List<String> _randomHobbies = [];

  static const List<String> _pickHobby = <String>[
    '영화보기',
    '드라마정주행',
    '카페탐방',
    '홈카페',
    '코인노래방',
    '수다',
    '쇼핑',
    '독서',
    '맛집탐방',
    '여행',
    '야구보기',
    '축구보기',
    '등산',
    '러닝',
    '산책',
    '댄스',
    '골프',
    '헬스',
    '필라테스/요가',
    '홈트',
    '클라이밍',
    '자전거라이딩',
    '드라이브',
    '캠핑',
    '볼링',
    '당구',
    '카공',
    '공부',
    '원데이클래스',
    '요리',
    '베이킹',
    '악기연주',
    '덕질',
    '음악듣기',
    '그림그리기',
    '게임',
    '봉사활동',
    '전시회관람',
    '명상',
    '프리다이빙',
    '크로스핏',
    '주짓수',
    '방탈출카페',
    '스카이다이빙',
    '오토바이',
    '승마',
    '펜싱',
    '축구',
    '야구',
    '보드게임',
    '마라톤',
    '테니스',
    '낚시',
    '배드민턴',
    '수영',
    '탁구',
    '복싱',
    '피아노',
    '바이올린',
    '기타',
    '드럼',
    '호캉스',
    '술',
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
  }

  @override
  void initState() {
    super.initState();
    _hobby = Pref.instance.profileData?.hobby;
    _pickRandomHobbies();
  }

  void _pickRandomHobbies() {
    _randomHobbies.clear();
    List<String> available =
        _pickHobby.where((e) => !(_hobby?.contains(e) ?? false)).toList();
    available.shuffle();
    _randomHobbies = available.take(3).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (_hobby != null) {
      buttonActive.value = true;
    }

    _controller.addListener(() {
      if (_controller.getTags == null) {
        buttonActive.value = false;
      } else if (_controller.getTags!.isEmpty) {
        buttonActive.value = false;
      } else {
        buttonActive.value = true;
      }
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
                start: 0.625,
                end: 0.75,
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
                    child: Builder(builder: (newContext) {
                      final ctx = newContext;

                      return InkWell(
                        onTap: () async {
                          Pref.instance.profileData?.hobby = null;
                          await Pref.instance.saveProfile();

                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            navigateHorizontally(
                              context: ctx,
                              widget: const RPInterest(),
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
                    }),
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
                  "취미가 무엇인가요?",
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
                child: Autocomplete<String>(
                  optionsViewBuilder: (context, onSelected, options) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Material(
                          borderRadius: BorderRadius.circular(10),
                          elevation: 4.0,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                                maxHeight: 220,
                                maxWidth: _distanceToField - 80),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: options.length,
                              itemBuilder: (BuildContext context, int index) {
                                final dynamic option = options.elementAt(index);
                                return TextButton(
                                  onPressed: () {
                                    onSelected(option);
                                  },
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      child: Text(
                                        '$option',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: Palette.primary),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text == '') {
                      return const Iterable<String>.empty();
                    }
                    return _pickHobby.where((String option) {
                      return option
                          .contains(textEditingValue.text.toLowerCase());
                    });
                  },
                  onSelected: (String selectedTag) {
                    _controller.addTag = selectedTag;
                  },
                  fieldViewBuilder: (context, ttec, tfn, onFieldSubmitted) {
                    return TextFieldTags(
                      textEditingController: ttec,
                      focusNode: tfn,
                      textfieldTagsController: _controller,
                      initialTags: _hobby,
                      textSeparators: const [' ', ',', '.'],
                      letterCase: LetterCase.normal,
                      validator: (String tag) {
                        if (_controller.getTags!.length >= 5) {
                          return '취미는 최대 5개까지 등록할 수 있어요!';
                        } else if (!_pickHobby.contains(tag)) {
                          return '등록된 취미 중에서 골라주세요!';
                        } else if (_controller.getTags!.contains(tag)) {
                          return '해당 취미를 이미 입력하셨어요!';
                        }
                        return null;
                      },
                      inputfieldBuilder:
                          (context, tec, fn, error, onChanged, onSubmitted) {
                        return ((context, sc, tags, onTagDelete) {
                          return TextField(
                            controller: tec,
                            focusNode: fn,
                            decoration: InputDecoration(
                              border: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Palette.primary, width: 3.0),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Palette.primary, width: 3.0),
                              ),
                              helperStyle: const TextStyle(
                                color: Palette.primary,
                              ),
                              hintText: _controller.hasTags ? '' : "취미를 입력하세요",
                              errorText: error,
                              prefixIconConstraints: BoxConstraints(
                                  maxWidth: _distanceToField * 0.74),
                              prefixIcon: tags.isNotEmpty
                                  ? SingleChildScrollView(
                                      controller: sc,
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                          children: tags.map((String tag) {
                                        return Container(
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20.0),
                                            ),
                                            color: Palette.secondary,
                                          ),
                                          margin: const EdgeInsets.only(
                                              right: 10.0),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                child: Text(
                                                  tag,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                onTap: () {
                                                  //print("$tag selected");
                                                },
                                              ),
                                              const SizedBox(width: 4.0),
                                              InkWell(
                                                child: const Icon(
                                                  EvaIcons.close,
                                                  size: 18.0,
                                                  color: Colors.white,
                                                ),
                                                onTap: () {
                                                  onTagDelete(tag);
                                                },
                                              )
                                            ],
                                          ),
                                        );
                                      }).toList()),
                                    )
                                  : null,
                            ),
                            onChanged: onChanged,
                            onSubmitted: onSubmitted,
                          );
                        });
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40, top: 20),
                child: Row(
                  children: [
                    const Text(
                      "추천 : ",
                      style: TextStyle(fontSize: 14, color: Palette.grey),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: _randomHobbies.map((e) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  _controller.addTag = e;
                                  _pickRandomHobbies();
                                });
                              },
                              child: TagItem(e),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(EvaIcons.refresh),
                      onPressed: () {
                        setState(() {
                          _pickRandomHobbies();
                        });
                      },
                    ),
                  ],
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
                                Pref.instance.profileData?.hobby =
                                    _controller.getTags;
                                log(Pref.instance.profileData.toString());
                                await Pref.instance.saveProfile();

                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  navigateHorizontally(
                                    context: ctx,
                                    widget: const RPInterest(),
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
