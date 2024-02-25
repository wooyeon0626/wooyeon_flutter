import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:wooyeon_flutter/config/config.dart';
import 'package:wooyeon_flutter/utils/jwt_utils.dart';

class GpsService {
  Dio dio = Dio();

  Future<bool> sendGps() async {
    const url = '${Config.domain}/users/profile/gps';

    try {
      Position position = await _determinePosition();

      log("[gpsLocation] ${position.latitude}|${position.longitude}");

      final response = await jwtPostRequest(
          url: Uri.parse(url),
          body: {'gpsLocation': "${position.latitude}|${position.longitude}"});

      if (response == null) {
        log("[gpsService] response null");
        return false;
      } else if (response.statusCode >= 200 && response.statusCode <= 206) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log('[SEND GPS ERROR] $e');
    }

    return false;
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar('GPS 사용 불가', 'GPS 상태를 확인해주세요!');
      return Future.error("Location services are disabled");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission == await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar('GPS 권한 없음', 'GPS 권한을 허용해주세요!');
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar('GPS 권한 없음', '기기 설정에서 GPS 권한을 직접 허용해주세요!');
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
