import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lms_android/models/announcement.dart';
import 'package:lms_android/baseURL.dart';
import 'package:lms_android/models/course.dart';
import 'local_storage_manager.dart';

class CourseService{
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

  Future<List<Announcement>> getAnnouncements(int courseId) async {
    final res = await http.get(
      Uri.parse("$baseURL/course/$courseId/announcements"),
      headers: {
        "Content-Type": "application/json",
        "Authorization" : "Bearer $_token",
      }
    );

    if (res.statusCode == 200) {
      List<Announcement> announcementList =<Announcement>[];
      List<dynamic> values = <Announcement>[];
      values = json.decode(res.body);
      if (values.isNotEmpty) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            announcementList.add(Announcement.fromJson(map));
          }
        }
      }
      return announcementList;
    } else {
      throw "Unable to retrieve announcements";
    }
  }

  Future<Course> getCourseDetails(int courseId) async {
    final res = await http.get(
        Uri.parse("$baseURL/course/$courseId"),
        headers: {
          "Content-Type": "application/json",
          "Authorization" : "Bearer $_token",
        }
    );

    if (res.statusCode == 200) {
      return Course.fromJson(jsonDecode(res.body));
    } else {
      throw "Unable to retrieve course";
    }
  }
}