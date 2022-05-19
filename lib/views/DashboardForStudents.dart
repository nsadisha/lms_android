import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lms_android/components/course_card.dart';
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

  late final userService;


  void initUserService() async {
    userService = await UserService.getInstance();
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
                          children: <Widget>[
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
                      children: <Widget>[
                        Text('Enrolled Courses',style: TextStyle(fontFamily: 'Mukta',fontSize: 30))
                      ],
                    ),
                  ),
                  Expanded(child: GridView.count(
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    primary: false,
                    children: <Widget>[
                      CourseCard(id: 122, courseName: 'Mobile app', courseCode: 'SENG 12233', lecturerName: 'amir malik')
                    ],
                    crossAxisCount: 2,))

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}



