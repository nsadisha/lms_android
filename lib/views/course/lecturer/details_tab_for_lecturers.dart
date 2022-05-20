import 'package:flutter/material.dart';
import 'package:lms_android/models/course.dart';
import 'package:lms_android/service/lecturer_service.dart';

class DetailsTabForLecturers extends StatefulWidget {
  final Course course;
  const DetailsTabForLecturers({Key? key, required this.course}) : super(key: key);

  @override
  State<DetailsTabForLecturers> createState() => _DetailsTabForLecturersState();
}

class _DetailsTabForLecturersState extends State<DetailsTabForLecturers> {

  late final LecturerService lecturerService;
  late final int enrolledStudents;


  @override
  void initState(){
    super.initState();
    initCourseService();
  }

  void initCourseService() async {
    await LecturerService.getInstance().then((value) => setState((){
      lecturerService = value;
    }));
  }

  Future<int> getStudentCount(int courseId) async {
    return await lecturerService.getEnrolledStudentsCount(courseId);
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
                  "Students Enrolled : ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
              ),
              FutureBuilder(
                future: getStudentCount(widget.course.id),
                builder: (context, snapshot){
                  if (snapshot.hasData) {
                    return Text(
                      snapshot.data.toString(),
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                      ),
                    );
                  }else if (snapshot.hasError) {
                    return const Text(
                      "None",
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