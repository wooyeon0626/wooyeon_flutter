import 'dart:async';

import 'package:get/get.dart';

class TimerController extends GetxController {
  static TimerController get to => Get.find();

  final duration = const Duration(minutes: 3);
  Rx<DateTime> endTime = (DateTime.now().add(const Duration(minutes: 3))).obs;
  Rx<Duration> remainingTime = (const Duration(minutes: 3)).obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _startTimer();
  }

  _startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final difference = endTime.value.difference(DateTime.now());
      if (difference.isNegative) {
        remainingTime.value = Duration.zero;
        timer.cancel();
      } else {
        remainingTime.value = difference;
      }
      update();
    });
  }

  resetTimer() {
    endTime.value = DateTime.now().add(duration);
    remainingTime.value = duration;
    _startTimer();
  }

  stopTimer() {
    _timer?.cancel();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
