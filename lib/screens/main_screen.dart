import 'dart:developer';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wooyeon_flutter/models/state/navigationbar_state.dart';
import '../config/palette.dart';
import '../service/recommend/gps_service.dart';

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

  void initGpsInfo() async {
    bool state = await GpsService().sendGps();
    if(state) {
      log('The GPS was sent successfully');
    } else {
      log('There was a problem sending GPS.');
    }
  }

  @override
  void initState() {
    super.initState();
    initGpsInfo();
  }

  @override
  Widget build(BuildContext context) {
    double bodyHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom -
        80;

    return Obx(() => Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,

            statusBarIconBrightness: Brightness.dark, // 안드로이드용 (어두운 아이콘)
            statusBarBrightness: Brightness.light, // iOS용 (어두운 아이콘)
          ),
          title: controller.getSelectedAppbar(),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
          body: controller.getSelectedWidget(bodyHeight),
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
        ));
  }
}
