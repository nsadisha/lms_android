import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:lms_android/models/course.dart';

import '../../models/user.dart';
import '../../service/student_service.dart';

class CourseDetails extends StatefulWidget {
  final Course course;
  final User student;
  final bool isStudent;

  const CourseDetails({Key? key, required this.course, required this.isStudent, required this.student}) : super(key: key);

  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {

  late final StudentService studentService;

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

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    navigateToCourseContent(){
      log("Success");
      // Navigator.pop(context, true);
    }

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        const Icon(
          Icons.menu_book,
          color: Colors.white,
          size: 30.0,
        ),
        const SizedBox(
          width: 90.0,
          child: Divider(color: Colors.blue),
        ),
        const SizedBox(height: 10.0),
        Flexible(
          child: Text(
            widget.course.courseName,
            style: const TextStyle(color: Colors.white, fontSize: 35.0),
          ),
        ),
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
                flex: 6,
                child: Text(
                  widget.course.courseCode,
                  style: const TextStyle(color: Colors.white, fontSize: 20.0),
                )),
          ],
        ),
      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
            padding: const EdgeInsets.only(left: 10.0),
            height: size.height * 0.5,
            decoration: const BoxDecoration(
              color: Color(0xff7c94b6),
            )
        ),
        Container(
          height: size.height * 0.5,
          padding: const EdgeInsets.all(40.0),
          width: size.width,
          decoration: const BoxDecoration(
              color: Color.fromRGBO(58, 66, 86, .9),
          ),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    );

    final bottomContentText = Column(
      children: [
        Text(
          widget.course.description,
          style: const TextStyle(color: Colors.black54, fontSize: 14.0),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 30.0),
        Text(
          "Conducted by : ${widget.course.lecturerName}",
          style: const TextStyle(fontSize: 16.0),
          textAlign: TextAlign.left,
        ),
      ],
    );

    final readButton = Container(
        margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        alignment: Alignment.center,
        child: Visibility(
          visible: widget.isStudent,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Container(
                  height: 50.0,
                  width: size.width * 0.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80.0),
                      gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 255, 136, 34),
                            Color.fromARGB(255, 255, 177, 41)
                          ]
                      )
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(75.0,15.0,75.0,15.0),
                  primary: Colors.white,
                  textStyle: const TextStyle(fontSize: 14),
                ),
                onPressed: () async {
                  var response = await studentService.enrollStudent(widget.student.id, widget.course.id);
                  if(response.statusCode == 200){
                    navigateToCourseContent();
                  }else{
                    log(response.statusCode.toString());
                  }
                },
                child: const Text(
                  "ENROLL",
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ],
          ),
        )
    );

    final bottomContent = Container(
      // height: size.height,
      width: size.width,
      // color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[
            bottomContentText, readButton],
        ),
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            topContent,
            bottomContent
          ],
        ),
      ),
    );
  }
}