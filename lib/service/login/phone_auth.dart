import 'dart:convert';
import 'dart:developer';

import 'package:wooyeon_flutter/config/config.dart';
import 'package:http/http.dart' as http;

class PhoneAuth {
  /// send phone number to server.
  /// then, the app will receive text message with a verification code to that phone number.
  Future<bool> sendPhoneNumberRequest({required String phone, required String signature}) async {
    const url = '${Config.domain}/auth/phone';

    ///TODO : signature 함께 넘기기
    final response = await http.post(Uri.parse(url), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
      body: jsonEncode(<String, String>{
        'to': phone,
        'signature': signature
      }),
    );

    if(response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202 || response.statusCode == 204) {
      Map<String, dynamic> decodedResponse = jsonDecode(response.body);
      //decodedResponse['statusName'] == 'success' || 'duplicated';
      return true;
    } else {
      log("Error with status code : ${response.statusCode}");
      return false;
    }

  }

  /// send phone number and code to server.
  /// you can check statuses like login state or sign up state etc.
  Future<dynamic> sendPhoneVerifyRequest({required String phone, required String code}) async {
    const url = '${Config.domain}/auth/phone/verify';

    final response = await http.post(Uri.parse(url), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
      body: jsonEncode(<String, String>{
        'phone': phone,
        'verifyCode' : code,
      }),
    );

    if(response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202 || response.statusCode == 204) {
      Map<String, dynamic> decodedResponse = jsonDecode(response.body);
      return decodedResponse;
    } else {
      log("Error with status code : ${response.statusCode}");
      return false;
    }
  }
}