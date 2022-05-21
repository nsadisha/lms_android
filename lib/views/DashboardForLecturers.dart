import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lms_android/components/course_card.dart';
import 'package:lms_android/models/user.dart';
import 'package:lms_android/models/course.dart';
import 'package:lms_android/service/course_service.dart';
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
  late final String name;



  void initServices() async {
    await UserService.getInstance().then((value) => setState((){
      userService = value;
    }));
    await CourseService.getInstance().then((value) => setState((){
      courseService = value;
    }));
    await getUser().then((value) => setState((){
      user = value;
    }));
  }

  //get enrolled courses
  Future<List<Course>> fetchCourses() async {
    User user = await userService.getUserDetails();
    return await courseService.getConductingCourses(user.id);
  }

  Future<User> getUser() async {
    User user = await userService.getUserDetails();
    return user;
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
                        FutureBuilder<User>(
                          future:getUser(),
                          builder: (context,snapshot) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:  <Widget>[
                                Text('Hello', style: TextStyle(fontFamily: 'Mukta',fontSize: 30,height: 0.9)),
                                Text('user.name', style: TextStyle(fontFamily: 'Mukta',fontSize: 30,height: 0.9)),
                                Text('Welcome Back!', style: TextStyle(fontFamily: 'Mukta',fontSize: 25,color: Colors.grey))

                              ],
                            );
                          }
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
                              return const Center(
                                child: Text(
                                    "Something went wrong!"
                                ),
                              );
                            }
                            //loading
                            return const CircularProgressIndicator();
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



