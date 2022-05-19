import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:lms_android/baseURL.dart';
import 'package:lms_android/models/user.dart';
import 'package:lms_android/service/course_service.dart';
import '../models/course.dart';
import 'local_storage_manager.dart';
import 'package:jwt_decode/jwt_decode.dart';

class UserService{
  final baseURL = BaseURL.url;
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
      _storage.setToken(obj["access_token"]);
      _storage.setRefreshToken(obj["refresh_token"]);
    } else {
      throw "Unable to retrieve user";
    }
    return res;
  }

  Future<http.Response> signup(String email, String name, String role, String password) async {
    final res = await http.post(
      Uri.parse("$baseURL/signup"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({'id': "", 'name': name, 'email': email, 'password': password, 'role': role})
    );

    if (res.statusCode != 201) {
      log(res.statusCode.toString());
      throw "Unable to create user";
    }
    return res;
  }

  Future<bool> isSigned() async {
    return await _storage.isTokenAvailable();
  }

  Future<String> getToken() async {
    return await _storage.getToken();
  }

   signout() async{
    _storage.removeAllTokens();
  }

  Future<User> getUserDetails() async {
    if(await isSigned()){
      Map<String, dynamic> payload = Jwt.parseJwt(await getToken());
      // log(payload["courses"].toString());
      return User.JWT(payload["sub"], payload["role"], List<String>.from(payload["courses"]));
    }else{
      throw "signin first";
    }
  }
}