import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lms_android/components/course_card.dart';
import 'package:lms_android/models/user.dart';
import 'package:lms_android/service/student_service.dart';
import '../../components/skew_cut.dart';
import '../../models/course.dart';
import '../../service/course_service.dart';
import '../../service/user_service.dart';

class DashboardForStudents extends StatefulWidget {
  const DashboardForStudents({Key? key}) : super(key: key);

  @override
  State<DashboardForStudents> createState() => _DashboardForStudentsState();
}

class _DashboardForStudentsState extends State<DashboardForStudents> {
  @override
  void initState(){
    super.initState();
    initServices();
  }

  late final UserService userService;
  late final CourseService courseService;
  late final StudentService studentService;
  late final Course course;
  late final User user ;

  void initServices() async {
    await UserService.getInstance().then((value) => setState((){
      userService = value;
    }));
    await CourseService.getInstance().then((value) => setState((){
      courseService = value;
    }));
    await StudentService.getInstance().then((value) => setState((){
      studentService = value;
    }));
    await userService.getUserDetails().then((value) => setState((){
      user = value;
    }));
  }

  //get enrolled courses
  Future<List<Course>> fetchCourses() async {
    await Future.delayed(const Duration(seconds: 1));
    return await courseService.getEnrolledCourses(user.id);
  }

  Future<User> getUserName() async {
    int id = user.id;
    return await studentService.getStudentDetails(id);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Column(
          children:<Widget>[
            Container(
              height: 150,
              margin: const EdgeInsets.only(top: 25.0, left: 18.0, right: 18.0, bottom: 30.0),
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blue.shade200,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FutureBuilder<User>(
                      future: getUserName(),
                      builder: (context,snapshot) {
                        if(snapshot.hasData){
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:  <Widget>[
                              const Text('Hello',
                                  style: TextStyle(
                                      fontFamily: 'Mukta',
                                      fontSize: 30,
                                      height: 0.9)
                              ),
                              Flexible(
                                  child: Text(snapshot.data!.name,
                                      style: const TextStyle(
                                          fontFamily: 'Mukta',
                                          fontSize: 30,
                                          height: 0.9,
                                      ),
                                  )
                              ),
                              const Text('Welcome Back!', style: TextStyle(fontFamily: 'Mukta',fontSize: 25,color: Colors.grey))

                            ],
                          );
                        }else if (snapshot.hasError) {
                          return const Text("Error");
                        }
                        return const CircularProgressIndicator();
                      }
                  ),

                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 80.0),
              child: ClipPath(
                clipper: SkewCut(),
                child: Container(
                  color: Colors.blue.withOpacity(0.1),
                  height: 50,
                  child: Row(
                    children: const <Widget>[
                      Padding(
                          padding: EdgeInsets.only(left: 18.0),
                          child: Text('Enrolled Courses',style:
                          TextStyle(fontFamily: 'Mukta',
                              fontSize: 30,
                              color: Color.fromRGBO(34, 47, 91, 1))
                          )
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
                child: FutureBuilder<List<Course>>(
                    future: fetchCourses(),
                    builder: (context,snapshot) {
                      if(snapshot.hasData) {
                        return ListView(
                          padding: const EdgeInsets.all(8),
                          children: snapshot.data!.map((course) =>
                              CourseCard(
                                  id: course.id,
                                  courseName: course.courseName,
                                  courseCode: course.courseCode, lecturerName:
                              course.lecturerName)
                          ).toList(),
                        );
                      }else if(snapshot.hasError){
                        log(snapshot.error.toString());
                        return const Center(child: Text("Error loading courses!"));
                      }

                      return const Center(child:CircularProgressIndicator());
                    }
                ))

          ],
        ),
      ),
    );
  }
}



