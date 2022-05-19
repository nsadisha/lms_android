import 'package:flutter/material.dart';
import 'package:lms_android/models/course.dart';

class DetailsTabForStudents extends StatefulWidget {
  final Course course;
  const DetailsTabForStudents({Key? key, required this.course}) : super(key: key);

  @override
  State<DetailsTabForStudents> createState() => _DetailsTabForStudentsState();
}

class _DetailsTabForStudentsState extends State<DetailsTabForStudents> {

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(widget.course.courseName));
  }
}