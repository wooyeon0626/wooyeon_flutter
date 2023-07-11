import 'dart:convert';
import 'package:http/http.dart' as http;

// class LoginService {
//   final String _baseUrl = 'https://backend-server.com';
//
//   Future<http.Response> register(String username, String password) {
//     return http.post(
//       Uri.parse('$_baseUrl/register'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, String>{
//         'username': username,
//         'password': password,
//       }),
//     );
//   }
//
//   Future<http.Response> login(String username, String password) {
//     return http.post(
//       Uri.parse('$_baseUrl/login'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, String>{
//         'username': username,
//         'password': password,
//       }),
//     );
//   }
// }

class LoginService {
  Future<http.Response> register(String username, String password) {
    return Future.value(http.Response('{"token": "dummy_token"}', 200));
  }

  Future<http.Response> login(String username, String password) {
    return Future.value(http.Response('{"token": "dummy_token"}', 200));
  }
}
