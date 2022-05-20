import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lms_android/components/background.dart';
import 'package:lms_android/service/course_service.dart';
import 'package:lms_android/service/user_service.dart';
import 'package:lms_android/views/course_content.dart';
import 'package:lms_android/views/course_details.dart';

import '../components/empty_state.dart';
import '../models/course.dart';
import '../models/user.dart';

class CourseView extends StatefulWidget {
  const CourseView({Key? key}) : super(key: key);

  @override
  State<CourseView> createState() => _CourseViewState();
}

class _CourseViewState extends State<CourseView> {

  late final UserService userService;
  late final CourseService courseService;
  late final User user;
  late final Course course;

  @override
  void initState(){
    initServices();
    super.initState();
  }

  void initServices() async {
    userService = await UserService.getInstance();
    courseService = await CourseService.getInstance();
    user = await userService.getUserDetails();
  }

  Future<Course> getCourse(int courseId) async {
    await Future.delayed(const Duration(seconds: 1));
    return await courseService.getCourseDetails(courseId);
  }

  Future<bool> hasAccess(int courseId) async {
    course = await getCourse(courseId);
    int index = user.courses.indexWhere((c) => c == course.courseCode);
    return index != -1;
  }

  bool isStudent() {
    return user.role == "STUDENT";
  }

  @override
  Widget build(BuildContext context) {

    final courseId = ModalRoute.of(context)!.settings.arguments as int;

    return FutureBuilder(
        future: hasAccess(courseId),
        builder: (context, snapshot){
          if (snapshot.hasData){
            if(snapshot.data == true){
              return CourseContent(course: course, isStudent: isStudent(), userId: user.id);
            }else{
              return CourseDetails(course: course, isStudent: isStudent());
            }
          }else if (snapshot.hasError) {
            return const EmptyState(text: "Course not found");
          }
          return const Scaffold(body: Background(child: CircularProgressIndicator()));
        }
    );
  }
}
