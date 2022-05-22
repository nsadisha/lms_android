import 'package:flutter/material.dart';
import 'package:lms_android/components/course_card.dart';
import 'package:lms_android/models/user.dart';
import 'package:lms_android/models/course.dart';
import 'package:lms_android/service/course_service.dart';
import 'package:lms_android/service/lecturer_service.dart';
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
  late final LecturerService lecturerService;
  late final Course course;
  late final User user ;


  void initServices() async {
    await UserService.getInstance().then((value) => setState((){
      userService = value;
    }));
    await CourseService.getInstance().then((value) => setState((){
      courseService = value;
    }));
    await LecturerService.getInstance().then((value) => setState((){
      lecturerService = value;
    }));
    await userService.getUserDetails().then((value) => setState((){
      user = value;
    }));
  }

  //get enrolled courses
  Future<List<Course>> fetchCourses() async {
    return await courseService.getConductingCourses(user.id);
  }

  Future<User> getUser() async {
    int id = user.id;
    return await lecturerService.getLecturerDetails(id);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:  const EdgeInsets.only(top: 25.0, left: 18.0, right: 18.0),
          child: Column(
            children:<Widget>[
              Container(
                height: 150,
                child: Row(
                  children: <Widget>[
                    FutureBuilder<User>(
                        future:getUser(),
                        builder: (context,snapshot) {
                          if(!snapshot.hasData){
                            return const Center(child: CircularProgressIndicator(),);
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:  <Widget>[
                              Text('Hello', style: TextStyle(fontFamily: 'Mukta',fontSize: 30,height: 0.9)),
                              Flexible(child:
                              Text(snapshot.data!.name,
                                style: TextStyle(fontFamily: 'Mukta',fontSize: 30,height: 0.9),
                                overflow: TextOverflow.fade,
                              )
                              ),
                              Text('Welcome Back!', style: TextStyle(fontFamily: 'Mukta',fontSize: 25,color: Colors.grey))

                            ],
                          );
                        }
                    ),

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
                        }else if(snapshot.connectionState == ConnectionState.waiting){
                          return const Center(child:CircularProgressIndicator());
                        }
                        else {
                          return const Center(child:CircularProgressIndicator());
                        }
                      }
                  ))

            ],
          ),
        ),
      ),
    );
  }
}



