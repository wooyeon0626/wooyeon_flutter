import 'dart:convert';
import 'dart:developer';
import 'dart:math' hide log;
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../../../config/config.dart';
import '../../encrypt/encrypt_service.dart';

class LoginService {
  Dio dio = Dio();

  Future<Response?> login(String email, String password) async {
    const getEncryptKey = '${Config.domain}/encrypt/key';
    const url = '${Config.domain}/auth/login';

    /// Session Key & IV 랜덤 생성
    final keyBytes = Uint8List.fromList(
        List<int>.generate(16, (i) => Random.secure().nextInt(256)));
    final iv = Uint8List.fromList(
        List<int>.generate(16, (i) => Random.secure().nextInt(256)));

    log('keyBytes : $keyBytes');
    log('iv : $iv');

    /// Password Base64 Encoding
    List<int> passwordBytes = utf8.encode(password);
    String passwordBase64 = base64.encode(passwordBytes);

    log('PasswordBase64 : $passwordBase64');

    /// Password Encrypt
    Uint8List ciphertextInt = AesEncryptionService()
        .encrypt(keyBytes: keyBytes, iv: iv, plaintext: passwordBase64);

    String ciphertext = base64Encode(ciphertextInt);
    log('CypherText : $ciphertext');

    /// 공개 키 가져오기
    final getEncryptKeyResponse = await http.get(
      Uri.parse(getEncryptKey),
    );

    late final String encryptKey;

    if (getEncryptKeyResponse.statusCode == 200 ||
        getEncryptKeyResponse.statusCode == 201 ||
        getEncryptKeyResponse.statusCode == 202 ||
        getEncryptKeyResponse.statusCode == 204) {
      Map<String, dynamic> decodedEncryptKey = jsonDecode(getEncryptKeyResponse.body);
      encryptKey = decodedEncryptKey['publicKey'];
    } else {
      log("Error with status code : ${getEncryptKeyResponse.statusCode}");
    }

    /// 공개 키로 세션키 암호화
    String sessionKey = base64Encode(keyBytes);
    String ivString = base64Encode(iv);

    Uint8List publicKeyBytes = base64Decode(encryptKey);
    log('publicKeyBytes : $publicKeyBytes');
    String cipherSessionKey = base64Encode(RsaEncryptionService().encrypt(sessionKey, publicKeyBytes));

    log('cipherSessionKey : $cipherSessionKey');

    try {
      final response = await dio.post(
        url,
        data: {
          'email': email,
          'encryptedPassword' : ciphertext,
          'encryptedKey' : '$ivString|$cipherSessionKey'
        },
      );

      return response;
    } catch (e) {
      // Dio 에러 처리
      log('Dio 에러 발생: $e');
      return null;
    }
  }

  // Future<Response?> login(String email, String password) async {
  //   const url = '${Config.domain}/auth/login';
  //
  //   try {
  //     final response = await dio.post(
  //       url,
  //       data: {
  //         'email': email,
  //         'password': password,
  //       },
  //     );
  //
  //     return response;
  //   } catch (e) {
  //     // Dio 에러 처리
  //     log('Dio 에러 발생: $e');
  //     return null;
  //   }
  // }

  /// 로그아웃 API && 로컬 로그아웃
  Future<http.Response> logout(String phone, String code) {
    const url = '${Config.domain}/auth/logout';

    return Future.value(http.Response('{"token": "dummy_token"}', 200));
  }
}
