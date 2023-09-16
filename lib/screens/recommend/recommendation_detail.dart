import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:swipable_stack/swipable_stack.dart';
import 'package:wooyeon_flutter/models/data/recommend_profile_model.dart';
import 'package:wooyeon_flutter/utils/util.dart';
import 'package:wooyeon_flutter/widgets/recommend/card_controller_in_detail.dart';
import 'package:wooyeon_flutter/widgets/tag_item.dart';

import '../../config/palette.dart';
import '../../widgets/image_slider.dart';

class RecommendationDetail extends StatefulWidget {
  final RecommendProfileModel profile;
  final SwipableStackController controller;

  const RecommendationDetail(this.profile, this.controller, {super.key});

  @override
  State<RecommendationDetail> createState() => _RecommendationDetailState();
}

class _RecommendationDetailState extends State<RecommendationDetail> {
  late ScrollController _scrollController;
  late double startDrag;
  final double _threshold = 30;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          controller: _scrollController,
          child: Listener(
            onPointerMove: (PointerMoveEvent event) {
              if (_scrollController.offset <=
                  _scrollController.position.minScrollExtent) {
                if (event.localDelta.dy > 0) {
                  if (event.localDelta.dy + startDrag > _threshold) {
                    Navigator.of(context).pop();
                  }
                }
              }
            },
            onPointerDown: (PointerDownEvent event) {
              startDrag = 0;
            },
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight + 0.01,
              ),
              child: IntrinsicHeight(
                child: SafeArea(
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 500,
                          child: Stack(children: [
                            ImageSlider(
                              images: widget.profile.profilePhoto,
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 40, vertical: 15),
                                        child: Row(
                                          children: [
                                            Text(
                                              widget.profile.nickname,
                                              style: const TextStyle(
                                                fontSize: 28,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 15),
                                              child: Text(
                                                "${birthdayToAge(widget.profile.birthday)}",
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
                                "${widget.profile.locationInfo},",
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
                          child: Divider(
                            thickness: 1.5,
                            color: Palette.inactive,
                          ),
                        ),
                        const Padding(
                            padding:
                            EdgeInsets.only(left: 40, bottom: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text("내 소개", style: TextStyle(
                                fontSize: 18,
                                color: Palette.grey,
                                fontWeight: FontWeight.bold,
                              ),),
                            )),
                        Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 40),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                children: [
                                  if (widget.profile.intro != null)
                                  Text("${widget.profile.intro}", style: const TextStyle(
                                    fontSize: 16,
                                    color: Palette.black,
                                  ),)
                                  else
                                    const Text("내 소개가 없어요", style: TextStyle(
                                      fontSize: 16,
                                      color: Palette.lightGrey,
                                    ),),
                                ],
                              ),
                            )),
                        if (widget.profile.mbti != null || widget.profile.interest != null || widget.profile.hobby != null)
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          child: Divider(
                            thickness: 1.5,
                            color: Palette.inactive,
                          ),
                        ),
                        if (widget.profile.mbti != null)
                        Padding(
                            padding:
                            const EdgeInsets.only(left: 40, bottom: 20),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  const Text("MBTI", style: TextStyle(
                                    fontSize: 18,
                                    color: Palette.grey,
                                    fontWeight: FontWeight.bold,
                                  ),),
                                  const SizedBox(width: 60,),
                                  Text("${widget.profile.mbti}", style: const TextStyle(
                                    fontSize: 18,
                                    color: Palette.black,
                                  ),),
                                ],
                              ),
                            )),
                        // Todo : 취미 여러개일 경우 아래로 자동으로 내려가도록 설정
                        if (widget.profile.hobby != null)
                          Padding(
                              padding:
                              const EdgeInsets.only(left: 40, bottom: 20),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    const Text("취미", style: TextStyle(
                                      fontSize: 18,
                                      color: Palette.grey,
                                      fontWeight: FontWeight.bold,
                                    ),),
                                    const SizedBox(width: 60,),
                                    for (var i = 0; i < widget.profile.hobby!.length; i++)
                                      TagItem(widget.profile.hobby![i]),
                                  ],
                                ),
                              )),
                        // Todo : 관심사 여러개일 경우 아래로 자동으로 내려가도록 설정
                        if (widget.profile.interest != null)
                          Padding(
                              padding:
                              const EdgeInsets.only(left: 40, bottom: 20),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    const Text("관심사", style: TextStyle(
                                      fontSize: 18,
                                      color: Palette.grey,
                                      fontWeight: FontWeight.bold,
                                    ),),
                                    const SizedBox(width: 60,),
                                    for (var i = 0; i < widget.profile.interest!.length; i++)
                                      TagItem(widget.profile.interest![i]),
                                  ],
                                ),
                              )),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 40),
                              child: CardControllerInDetail(widget.controller),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
