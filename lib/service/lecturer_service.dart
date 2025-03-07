import 'dart:convert';
import 'dart:developer';
import 'package:lms_android/models/student.dart';

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

  Future<List<Student>> getEnrolledStudentsMarks(int courseId) async {
    final res = await http.get(
      Uri.parse("$baseURL/lecturer/$courseId/students/marks"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $_token"
      },
    );

    if (res.statusCode == 200) {
      List<Student> studentList = <Student>[];
      List<dynamic> values=<dynamic>[];

      values = json.decode(res.body);

      if(values.isNotEmpty){
        for(int i=0;i<values.length;i++){
          if(values[i]!=null){
            Map<String,dynamic> map = values[i];
            studentList.add(Student.fromJson(map));
          }
        }
      }

      return studentList;

    } else {
      throw "Unable to retrieve student marks";
    }
  }

  Future<User> getLecturerDetails(int lecturerId) async {
    final res = await http.get(
      Uri.parse("$baseURL/lecturer/$lecturerId"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $_token"
      },
    );
    if (res.statusCode == 200) {
      return User.fromJson(jsonDecode(res.body));
    } else {
      throw "Unable to retrieve lecturer";
    }
  }

  Future<http.Response> assignMarksToStudent(int courseId, int studentId, double marks) async {
    final res = await http.post(
      Uri.parse("$baseURL/lecturer/$courseId/student/$studentId/mark/$marks"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $_token"
      },
    );
    if (res.statusCode == 200) {
      return res;
    } else {
      throw "Unable to get set marks for student";
    }
  }
}

