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

    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        children: [
          SizedBox(height: size.height * 0.03),
          Text(
            widget.course.courseName,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 24
            ),
          ),
          Text(
            widget.course.courseCode,
            style: const TextStyle(
                color: Colors.grey,
                fontSize: 16
            ),
          ),
          SizedBox(height: size.height * 0.03),
          Text(
            "Conducted by :  ${widget.course.lecturerName}",
            style: const TextStyle(
                color: Colors.black,
                fontSize: 16
            ),
          ),
          SizedBox(height: size.height * 0.03),
          Text(
              widget.course.description,
              style: const TextStyle(
                color: Colors.black45,
                fontSize: 14,
              ),
              textAlign: TextAlign.justify
          ),
          SizedBox(height: size.height * 0.05),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Your Marks : ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              Text(
                "13.0%",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 14,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}