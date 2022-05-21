import 'dart:convert';

import '../baseURL.dart';
import 'package:http/http.dart' as http;
import 'local_storage_manager.dart';

class StudentService {
  final baseURL = BaseURL.url;
  late final String _token;
  static StudentService? _instance;

  static Future<StudentService> getInstance() async {
    if(_instance == null){
      final lsm = await LocalStorageManager.getInstance();
      _instance = StudentService._(await lsm.getToken());
    }
    return _instance!;
  }

  StudentService._(String token) : _token = token;

  Future<double> getMarksForCourse(int studentId, int courseId) async {
    final res = await http.get(
      Uri.parse("$baseURL/student/$studentId/course/$courseId"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $_token"
      },
    );
    if (res.statusCode == 200) {
      return json.decode(res.body);
    } else {
      throw "Unable to get enrolled students count";
    }
  }

  Future<http.Response> unEnrollStudent(int studentId, int courseId) async {
    final res = await http.post(
      Uri.parse("$baseURL/student/$studentId/unenroll/$courseId"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $_token"
      },
    );
    if (res.statusCode == 200) {
      return res;
    } else {
      throw "Unable to unenroll student";
    }
  }

  Future<http.Response> enrollStudent(int studentId, int courseId) async {
    final res = await http.post(
      Uri.parse("$baseURL/student/$studentId/enroll/$courseId"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $_token"
      },
    );
    if (res.statusCode == 200) {
      return res;
    } else {
      throw "Unable to enroll student";
    }
  }

}

