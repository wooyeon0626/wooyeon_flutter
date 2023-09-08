import 'dart:convert';
import 'dart:developer';

import 'package:wooyeon_flutter/config/config.dart';
import 'package:http/http.dart' as http;
import 'package:wooyeon_flutter/models/pref.dart';

class EmailAuth {
  /// send email address to server.
  /// then, an email is sent with a deep link.
  Future<bool> sendEmailRequest({required String email}) async {
    const url = '${Config.domain}/auth/email';

    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202 || response.statusCode == 204) {
      return true;
    } else {
      log("Error with status code : ${response.statusCode}");
      return false;
    }
  }

  /// send email address and authentication token to server.
  Future<bool> sendEmailVerifyRequest(
      {required String email, required String token}) async {
    const url = '${Config.domain}/auth/email/verify';

    String phone = (await Pref.instance.get('phone_number'))!;

    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'phone': phone,
        'email': email,
        'authToken': token,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202 || response.statusCode == 204) {
      Map<String, dynamic> decodedResponse = jsonDecode(response.body);

      final String emailAuth = decodedResponse['emailAuth'];

      if (emailAuth == 'success') {
        return true;
      } else if (emailAuth == 'fail') {
        return false;
      } else {
        log("An error occurred during email verification process");
        return false;
      }
    } else {
      log("Error with status code : ${response.statusCode}");
      return false;
    }
  }
}
