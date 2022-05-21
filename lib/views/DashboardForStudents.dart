import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lms_android/components/course_card.dart';
import 'package:lms_android/models/User.dart';
import 'package:lms_android/service/CourseService.dart';
import '../models/course.dart';
import '../service/UserService.dart';

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
  late final User user;
  late final Course course;

  void initServices() async {
    await UserService.getInstance().then((value) => setState((){
      userService = value;
    }));
    //await userService.getToken().then((value) => print(value));
    await CourseService.getInstance().then((value) => setState((){
      courseService = value;
    }));
    await userService.getUserDetails().then((value) => setState((){
      user = value;
    }));
  }

  //get enrolled courses
  Future<List<Course>> fetchCourses(studentId) async {
   return await courseService.getEnrolledCourses(studentId);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Padding(
              padding:  EdgeInsets.all(18.0),
              child: Column(
                children:<Widget>[
                  Container(
                    height: 150,
                    child: Row(
                      children: <Widget>[

                    Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                        image: AssetImage("assets/images/top_wave_01.png"),
                        alignment: Alignment.topLeft,
                            ),
                        ),
                    ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const <Widget>[
                            Text('Hello', style: TextStyle(fontFamily: 'Mukta',fontSize: 30,height: 0.9)),
                            Text('Devid decor', style: TextStyle(fontFamily: 'Mukta',fontSize: 30,height: 0.9)),
                            Text('Welcome Back!', style: TextStyle(fontFamily: 'Mukta',fontSize: 25,color: Colors.grey))

                          ],
                        ),
                        SizedBox(width:100,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              width: 80,
                              child: (
                                Image(image: AssetImage('assets/images/graduate.png'))
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 60,
                    child: Row(
                      children: const <Widget>[
                        Text('Enrolled Courses',style: TextStyle(fontFamily: 'Mukta',fontSize: 30))
                      ],
                    ),
                  ),
                  // Expanded(
                  //     child: FutureBuilder<List<Course>>(
                  //   future: fetchCourses(1),
                  //   builder: (context,snapshot) {
                  //     if(snapshot.connectionState==ConnectionState.waiting) {
                  //       return const Center(child:  CircularProgressIndicator());
                  //     }
                  //     if(snapshot.connectionState==ConnectionState.none){
                  //       return const Text('Error while loading');
                  //     }
                  //     return GridView.count(
                  //       mainAxisSpacing: 10,
                  //       crossAxisSpacing: 10,
                  //       primary: false,
                  //       crossAxisCount: 2,
                  //       children:snapshot.data!.map((course) =>
                  //           CourseCard(
                  //           id: course.id,
                  //           courseName: course.courseName,
                  //           courseCode:course.courseCode, lecturerName:
                  //           course.lecturerName)).toList(),
                  //     );
                  //   }
                  // ))

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}



