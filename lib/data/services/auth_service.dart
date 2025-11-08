import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final Dio dio;
  AuthService(this.dio);

  static const AUTH_PATH = '/auth';
  static const ACCESS_TOKEN_KEY = 'access_token_key';
  static const MAINTAIN_CONNECTED_KEY = 'maintain_connected_key';

  Future<Response> authenticate(String username, String password) async {
    //mocked delay
    await Future.delayed(const Duration(seconds: 3));

    final data = {
      "login": username,
      "password": password,
    };

    final response = await dio.post(
      AUTH_PATH,
      data: data,
    );

    return response;
  }

  Future<void> saveAccessToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(ACCESS_TOKEN_KEY, token);
  }

  Future<String?> getAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(ACCESS_TOKEN_KEY);
  }

  Future<void> saveMaintainConnected(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(MAINTAIN_CONNECTED_KEY, value);
  }

  Future<bool?> getMaintainConnected() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(MAINTAIN_CONNECTED_KEY);
  }
}
