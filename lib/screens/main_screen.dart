import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wooyeon_flutter/models/state/navigationbar_state.dart';
import '../config/palette.dart';

var iconList = [
  EvaIcons.compass,
  EvaIcons.flag,
  EvaIcons.heart,
  EvaIcons.messageCircle,
  EvaIcons.person,
];

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  final controller = Get.put(NavigationBarState());

  @override
  Widget build(BuildContext context) {

    // Todo : Status Bar Color 정하기
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ));

    return SafeArea(
      child: Obx(() => Scaffold(
        resizeToAvoidBottomInset : false,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            title: controller.getSelectedAppbar(),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
        ),
            body: controller.getSelectedWidget(),
            backgroundColor: Colors.white,
            bottomNavigationBar: AnimatedBottomNavigationBar(
              height: 80,
              splashSpeedInMilliseconds: 200,
              gapLocation: GapLocation.end,
              gapWidth: 0,
              backgroundColor: Colors.white,
              inactiveColor: Palette.inactive,
              activeColor: Palette.primary,
              icons: iconList,
              activeIndex: controller.getInx(),
              onTap: (index) => controller.setInx(index),
              iconSize: 36,
            ),
          )),
    );
  }
}
