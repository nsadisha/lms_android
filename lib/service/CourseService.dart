import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:lms_android/baseURL.dart';
import 'package:lms_android/models/course.dart';

import 'LocalStorageManager.dart';

class CourseService {

  final baseURL = BaseURL.url;
  static CourseService? _instance;
  late final String _token;

  static Future<CourseService> getInstance() async {
    if(_instance == null){
      final lsm = await LocalStorageManager.getInstance();
      _instance = CourseService._(await lsm.getToken());
    }
    return _instance!;
  }

  CourseService._(String token) : _token = token;

  Future<List<Course>> getAllCourses() async {
    final res = await http.get(
      Uri.parse("$baseURL/course/all"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $_token"
      },
    );
    if (res.statusCode == 200) {
      List<Course> courseList = <Course>[];
      List<dynamic> values=<dynamic>[];

      values = json.decode(res.body);

      if(values.isNotEmpty){
        for(int i=0;i<values.length;i++){
          if(values[i]!=null){
            Map<String,dynamic> map = values[i];
            courseList .add(Course.fromJson(map));
          }
        }
      }
      return courseList;

    } else {
      throw "Unable to retrieve courses";
    }
  }

  Future<List<Course>> getEnrolledCourses(int studentId) async {
    final res = await http.get(
      Uri.parse("$baseURL/student/$studentId/courses"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $_token"
      },
    );
    if (res.statusCode == 200) {
      List<Course> courseList = <Course>[];
      List<dynamic> values=<dynamic>[];

      values = json.decode(res.body);

      if(values.isNotEmpty){
        for(int i=0;i<values.length;i++){
          if(values[i]!=null){
            Map<String,dynamic> map = values[i];
            courseList .add(Course.fromJson(map));
          }
        }
      }
      return courseList;

    } else {
      throw "Unable to retrieve courses";
    }
  }

  Future<List<Course>> getConductingCourses(int lecturerId) async {
    final res = await http.get(
      Uri.parse("$baseURL/lecturer/$lecturerId/courses"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $_token"
      },
    );
    if (res.statusCode == 200) {
      List<Course> courseList = <Course>[];
      List<dynamic> values=<dynamic>[];

      values = json.decode(res.body);

      if(values.isNotEmpty){
        for(int i=0;i<values.length;i++){
          if(values[i]!=null){
            Map<String,dynamic> map = values[i];
            courseList .add(Course.fromJson(map));
          }
        }
      }
      return courseList;

    } else {
      throw "Unable to retrieve courses";
    }
  }


}