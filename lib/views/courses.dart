import 'package:flutter/material.dart';
import 'package:lms_android/models/Course.dart';
import 'package:lms_android/service/CourseService.dart';
import '../components/CourseCard.dart';

class Courses extends StatelessWidget {
  const Courses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'All courses',
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    );
  }
}