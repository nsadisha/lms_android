import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {

    final int id;
    final String courseName;
    final String courseCode;
    final String lecturerName;

    const CourseCard({
        Key? key, required this.id, required this.courseName, required this.courseCode, required this.lecturerName,
    }) : super(key: key);

}