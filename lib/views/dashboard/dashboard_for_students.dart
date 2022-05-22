import 'package:flutter/material.dart';
import 'package:lms_android/components/course_card.dart';
import 'package:lms_android/models/user.dart';
import 'package:lms_android/service/student_service.dart';
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
        child: Padding(
          padding:  const EdgeInsets.only(top: 25.0, left: 18.0, right: 18.0),
          child: Column(
            children:<Widget>[
              Container(
                height: 150,
                child: Row(
                  children: <Widget>[

                    FutureBuilder<User>(
                        future: getUserName(),
                        builder: (context,snapshot) {
                          if(snapshot.connectionState==ConnectionState.waiting) {
                            return const Center(child:  CircularProgressIndicator());
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:  <Widget>[
                              Text('Hello', style: TextStyle(fontFamily: 'Mukta',fontSize: 30,height: 0.9)),
                              Flexible(child: Text(snapshot.data!.name, style: TextStyle(fontFamily: 'Mukta',fontSize: 30,height: 0.9))),
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
                    Text('Enrolled Courses',style: TextStyle(fontFamily: 'Mukta',fontSize: 30))
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
                        }else
                        if(snapshot.connectionState == ConnectionState.waiting){
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



