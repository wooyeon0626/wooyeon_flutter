import 'dart:developer';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'package:wooyeon_flutter/models/pref.dart';
import 'package:wooyeon_flutter/screens/login/register_profile/rp_profile_image.dart';
import 'package:wooyeon_flutter/widgets/login/profile_progressbar.dart';
import 'package:wooyeon_flutter/widgets/next_button_async.dart';

import '../../../config/palette.dart';
import '../../../utils/transition.dart';

class RPInterest extends StatefulWidget {
  const RPInterest({super.key});

  @override
  State<RPInterest> createState() => _RPInterestState();
}

class _RPInterestState extends State<RPInterest> {
  final TextfieldTagsController _controller = TextfieldTagsController();
  final buttonActive = ValueNotifier<bool>(false);
  late double _distanceToField;
  List<String>? _interest;

  static const List<String> _pickInterest = <String>[
    '넷플릭스', 'TV 예능', '야구', '축구', '해외축구', '자격증', '외국어 공부', '환경 보호', '해리포터', '스포티파이', '아쿠아리움',
    '인스타그램', '언어 교환', '소셜 미디어', '힙합', 'k-pop', '스킨케어', '사진', '시', '소설', '문학', '기후변화', '투자', '주식',
    '빈티지 패션' '패션', '컨트리 뮤직', '별자리 운세', '평등', '창업', 'SF', '식물', '교환학생', '예술', '정치', '박물관', '먹방',
    '팟캐스트', '부동산', '수제 맥주', '와인', '칵테일', '브이로그', '발라드', '유튜브', '비건 요리', '리그오브레전드', '배틀그라운드',
    '포트나이트', 'NBA', 'MLB', '블로그', '애니메이션', '틱톡', '구제샵', '팝', '락', '자동차', '코딩'
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
  }

  @override
  void initState() {
    super.initState();
    _interest = Pref.instance.profileData?.interest;
  }

  @override
  Widget build(BuildContext context) {
    if (_interest != null) {
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
                start: 0.75,
                end: 0.875,
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
                          Pref.instance.profileData?.interest = null;
                          await Pref.instance.saveProfile();

                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            navigateHorizontally(
                              context: ctx,
                              widget: const RPImage(),
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
                  "요즘 관심 있는 건\n무엇인가요?",
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
                    return _pickInterest.where((String option) {
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
                      initialTags: _interest,
                      textSeparators: const [' ', ','],
                      letterCase: LetterCase.normal,
                      validator: (String tag) {
                        if (_controller.getTags!.length >= 5) {
                          return '관심사는 최대 5개까지 등록할 수 있어요!';
                        } else if (!_pickInterest.contains(tag)) {
                          return '등록된 관심사 중에서 골라주세요!';
                        } else if (_controller.getTags!.contains(tag)) {
                          return '해당 관심사를 이미 입력하셨어요!';
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
                              hintText: _controller.hasTags ? '' : "관심사를 입력하세요",
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
                                Pref.instance.profileData?.interest =
                                    _controller.getTags;
                                log(Pref.instance.profileData.toString());
                                await Pref.instance.saveProfile();

                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  navigateHorizontally(
                                    context: ctx,
                                    widget: const RPImage(),
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
