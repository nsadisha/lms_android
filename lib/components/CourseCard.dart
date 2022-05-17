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
                            Align(
                                alignment: Alignment.topLeft,
                                child: SizedBox(
                                    width: 250,
                                    height: 36,
                                    child: DecoratedBox(
                                        decoration: BoxDecoration(
                                            color: c,
                                            borderRadius: const BorderRadius.only(
                                                topLeft: Radius.zero,
                                                topRight: Radius.zero,
                                                bottomLeft: Radius.zero,
                                                bottomRight: Radius.circular(40.0)
                                            ),
                                        ),
                                    ),
                                ),
                            ),
                            ListTile(
                                title: Text(courseName),
                                subtitle: Text(
                                courseCode,
                                style: TextStyle(color: Colors.black.withOpacity(0.6)),
                                ),
                            ),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Text(
                                        'Conducted by: $lecturerName',
                                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                                    ),
                                ),
                            ),
                        ],
                    ),
                ),
            ),
        );
      
    }
}