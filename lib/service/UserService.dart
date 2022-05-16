import 'dart:convert';
import 'package:http/http.dart' as http;
import 'LocalStorageManager.dart';

class UserService{
  final baseURL = "http://192.168.8.182:8090";
  final LocalStorageManager _storage;
  static UserService? _instance;

  static Future<UserService> getInstance() async {
    if(_instance == null){
      final lsm = await LocalStorageManager.getInstance();
      _instance = UserService._(lsm);
    }
    return _instance!;
  }

  UserService._(LocalStorageManager lsm) : _storage = lsm;

  Future<http.Response> signin(String email, String password) async {
    //log(Uri.parse(loginURL).toString());
    final res = await http.post(
      Uri.parse("$baseURL/login"),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      encoding: Encoding.getByName('utf-8'),
      body: {
        "email": email,
        "password": password
      },
    );

    if (res.statusCode == 200) {
      final obj = jsonDecode(res.body);
      //log('success: $obj');
      _storage.setToken(obj["access_token"]);
      _storage.setRefreshToken(obj["refresh_token"]);
    } else {
      throw "Unable to retrieve user";
    }
    return res;
  }

  Future<bool> isSigned() async {
    return await _storage.isTokenAvailable();
  }

  Future<String> getToken() async {
    return await _storage.getToken();
  }
}