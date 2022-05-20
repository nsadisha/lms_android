import 'dart:convert';

import '../baseURL.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;
import 'local_storage_manager.dart';

class LecturerService {
  final baseURL = BaseURL.url;
  late final String _token;
  static LecturerService? _instance;

  static Future<LecturerService> getInstance() async {
    if(_instance == null){
      final lsm = await LocalStorageManager.getInstance();
      _instance = LecturerService._(await lsm.getToken());
    }
    return _instance!;
  }

  LecturerService._(String token) : _token = token;

  Future<int> getEnrolledStudentsCount(int courseId) async {
    final res = await http.get(
      Uri.parse("$baseURL/lecturer/$courseId/students"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $_token"
      },
    );
    if (res.statusCode == 200) {
      return json.decode(res.body).length;
    } else {
      throw "Unable to get enrolled students count";
    }
  }

}
