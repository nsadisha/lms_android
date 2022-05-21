import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lms_android/models/course.dart';
import 'package:lms_android/service/student_service.dart';

class DetailsTabForStudents extends StatefulWidget {
  final Course course;
  final int userId;
  const DetailsTabForStudents({Key? key, required this.course, required this.userId}) : super(key: key);

  @override
  State<DetailsTabForStudents> createState() => _DetailsTabForStudentsState();
}

class _DetailsTabForStudentsState extends State<DetailsTabForStudents> {

  late final StudentService studentService;
  late final double marks;


  @override
  void initState(){
    super.initState();
    initStudentService();
  }

  void initStudentService() async {
    await StudentService.getInstance().then((value) => setState((){
      studentService = value;
    }));
  }

  Future<double> getStudentMarks() async {
    return await studentService.getMarksForCourse(widget.userId, widget.course.id);
  }

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
            children: [
              const Text(
                "Your Marks : ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              FutureBuilder(
                  future: getStudentMarks(),
                  builder: (context, snapshot){
                    if (snapshot.hasData) {
                      return Text(
                        "${snapshot.data} %",
                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 14,
                        ),
                      );
                    }else if (snapshot.hasError) {
                      return const Text(
                        "Not assigned yet",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      );
                    }
                    return const CircularProgressIndicator();
                  }
              ),
            ],
          ),
          SizedBox(height: size.height * 0.05),

          Container(
            alignment: Alignment.bottomRight,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    height: 10.0,
                    width: size.width * 0.5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        border: Border.all(width: 2.0, color: Colors.redAccent)
                    ),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    primary: Colors.white,
                    textStyle: const TextStyle(fontSize: 12),
                  ),
                  onPressed: () => showDialog<bool>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Center(child: Text('Unenroll')),
                        content: Text("Are you sure you want to unenroll from the course module ${widget.course.courseName}?"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text(
                                'UNENROLL',
                              style: TextStyle(
                                  color: Colors.redAccent
                              )
                            ),
                          ),
                        ],
                      ),
                    ).then((exit) async {
                    if (exit == null) return;
                      if (exit) {
                        var response = await studentService.unEnrollStudent(widget.userId, widget.course.id);
                        if(response.statusCode == 200){
                          log(response.statusCode.toString());
                          // setState(() {});
                        }else{
                          log(response.statusCode.toString());
                        }
                      }
                    }),
                  child: const Text(
                    "UNENROLL",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}