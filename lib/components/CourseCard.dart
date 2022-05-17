import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {

    final int id;
    final String courseName;
    final String courseCode;
    final String lecturerName;

    const CourseCard({
        Key? key, required this.id, required this.courseName, required this.courseCode, required this.lecturerName,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {

        Color c = Color((id * 1000000 * 3 * 0xFFFFFF).toInt()).withOpacity(1.0);

        return Card(
            clipBehavior: Clip.antiAlias,
            child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                },
                child: SizedBox(
                    width: 350,
                    height: 150,
                    child: Column(
                        children: [

                        ],
                    ),
                ),
            ),
        );
      
    }
}