import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lms_android/components/course_card.dart';
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
    initUserService();
  }

  late final UserService userService;
  late final CourseService courseService;
  List <Course>_test =[
    Course(id: 1221, courseName: 'Mobile Application', courseCode: 'seng 12223', lecturerName: 'amara', description: 'hi'),
    Course(id: 3221, courseName: 'Mobile Application', courseCode: 'seng 12223', lecturerName: 'amara', description: 'hi'),
    Course(id: 1321, courseName: 'Mobile Application', courseCode: 'seng 12223', lecturerName: 'amara', description: 'hi')

  ];

  void initUserService() async {
    userService = await UserService.getInstance();
  }


  Future<List<Course>> fetchCourses() async {
   return await Future<List<Course>>.delayed(const Duration(seconds: 5),()=>_test);

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
                  Expanded(child: FutureBuilder<List<Course>>(
                    future:fetchCourses(),
                    builder: (context,snapshot) {
                      if(snapshot.connectionState==ConnectionState.waiting) {
                        return Center(child:  CircularProgressIndicator());
                      }

                      return GridView.count(
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        primary: false,
                        children:snapshot.data!.map((e) => CourseCard(id: e.id, courseName: e.courseName, courseCode:e.courseCode, lecturerName: e.lecturerName)).toList(),
                        crossAxisCount: 2,);
                    }
                  ))

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}



