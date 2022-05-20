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
          )
        ],
      ),
    );
  }
}