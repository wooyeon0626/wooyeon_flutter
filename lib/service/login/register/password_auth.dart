import 'package:dio/dio.dart';

import '../../../config/config.dart';

class PasswordAuth {
  Future<bool> sendPassword(String password) async {
    const url = '${Config.domain}/users/register/profile';

    try {
      Dio dio = Dio();
      // 구현 필요
      return true;
    } catch (e) {
      // 구현 필요
      return false;
    }
  }
}