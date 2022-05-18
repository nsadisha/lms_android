import 'package:flutter/material.dart';
import 'package:lms_android/models/Course.dart';
import 'package:lms_android/service/CourseService.dart';
import '../components/CourseCard.dart';

class Courses extends StatefulWidget {
  const Courses({Key? key}) : super(key: key);

  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {

  late final CourseService courseService;

  @override
  void initState(){
    super.initState();
    initCourseService();
  }

}