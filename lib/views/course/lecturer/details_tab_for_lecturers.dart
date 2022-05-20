import 'package:flutter/material.dart';
import 'package:lms_android/models/course.dart';

class DetailsTabForLectures extends StatefulWidget {
  final Course course;
  const DetailsTabForLectures({Key? key, required this.course}) : super(key: key);

  @override
  State<DetailsTabForLectures> createState() => _DetailsTabForLecturesState();
}

class _DetailsTabForLecturesState extends State<DetailsTabForLectures> {

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(widget.course.courseName));
  }
}