import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/palette.dart';
import '../../models/state/match_tabbar_state.dart';

class Match extends StatefulWidget {
  const Match({super.key});

  @override
  State<Match> createState() => _Match();
}

class _Match extends State<Match> with SingleTickerProviderStateMixin {
  final MatchTabBarState tabController = Get.put(MatchTabBarState());
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = TweenSequence<double>([
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 1.0, end: 1.2),
        weight: 0.5,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 1.2, end: 1.0),
        weight: 0.5,
      ),
    ]).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.ease,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _animationController.reset();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        tabController.setInx(0);
                        _startAnimation();
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: tabController.getInx() == 0
                                  ? Palette.secondary
                                  : Palette.inactive,
                              width: 2,
                            ),
                          ),
                        ),
                        child: AnimatedBuilder(
                          animation: _animation,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: tabController.getInx() == 0 ? _animation.value : 1.0,
                              child: Text(
                                '내가 받은\n좋아요',
                                style: TextStyle(
                                  color: tabController.getInx() == 0
                                      ? Palette.secondary
                                      : Palette.lightGrey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        tabController.setInx(1);
                        _startAnimation();
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: tabController.getInx() == 1
                                  ? Palette.secondary
                                  : Palette.inactive,
                              width: 2,
                            ),
                          ),
                        ),
                        child: AnimatedBuilder(
                          animation: _animation,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: tabController.getInx() == 1 ? _animation.value : 1.0,
                              child: Text(
                                '내가 보낸\n좋아요',
                                style: TextStyle(
                                  color: tabController.getInx() == 1
                                      ? Palette.secondary
                                      : Palette.lightGrey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        tabController.setInx(2);
                        _startAnimation();
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: tabController.getInx() == 2
                                  ? Palette.secondary
                                  : Palette.inactive,
                              width: 2,
                            ),
                          ),
                        ),
                        child: AnimatedBuilder(
                          animation: _animation,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: tabController.getInx() == 2 ? _animation.value : 1.0,
                              child: Text(
                                '매치된\n친구',
                                style: TextStyle(
                                  color: tabController.getInx() == 2
                                      ? Palette.secondary
                                      : Palette.lightGrey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: tabController.getSelectedWidget(),
          ),
        ],
      ),
    );
  }
}
