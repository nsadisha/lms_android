import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lms_android/components/course_card.dart';
import 'package:lms_android/models/User.dart';
import 'package:lms_android/models/course.dart';
import 'package:lms_android/service/CourseService.dart';
import 'package:lms_android/service/user_service.dart';

class DashboardForLecturers extends StatefulWidget {
  const DashboardForLecturers({Key? key}) : super(key: key);

  @override
  State<DashboardForLecturers> createState() => _DashboardForLecturersState();
}

class _DashboardForLecturersState extends State<DashboardForLecturers> {
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
    userService = await UserService.getInstance();
    courseService = await CourseService.getInstance();
    //user = await userService.getUserDetails();
  }

  //get conducting courses
  Future<List<Course>> fetchCourses(lecturerId) async {
    return await courseService.getConductingCourses(lecturerId);

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
                            Text('name', style: TextStyle(fontFamily: 'Mukta',fontSize: 30,height: 0.9)),
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
                                  Image(image: AssetImage('assets/images/teacher.png'))
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
                        Text('Conducting Courses',style: TextStyle(fontFamily: 'Mukta',fontSize: 30))
                      ],
                    ),
                  ),
                  Expanded(child: FutureBuilder<List<Course>>(
                      future:fetchCourses(user.id),
                      builder: (context,snapshot) {
                        if(snapshot.connectionState==ConnectionState.waiting) {
                          return Center(child:  CircularProgressIndicator());
                        }
                        if(snapshot.connectionState==ConnectionState.none){
                          return Text('Error while loading');
                        }
                        return GridView.count(
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          primary: false,
                          crossAxisCount: 2,
                          children:snapshot.data!.map((course) =>
                              CourseCard(
                                  id: course.id,
                                  courseName: course.courseName,
                                  courseCode:course.courseCode, lecturerName:
                                  course.lecturerName)).toList(),
                        );
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



