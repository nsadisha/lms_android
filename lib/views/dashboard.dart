import 'package:flutter/material.dart';
import 'package:lms_android/models/user.dart';
import 'package:lms_android/views/DashboardForLecturers.dart';
import 'package:lms_android/views/DashboardForStudents.dart';
import '../service/user_service.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {


  @override
  void initState(){
    super.initState();

  }

  late final UserService userService;
  late final String userRole;

  Future<User> getUserRole() async {
    userService = await UserService.getInstance();
    User user = await userService.getUserDetails();
    return user;
  }


  @override
  Widget build(BuildContext context) {
  return FutureBuilder<User>(
    future: getUserRole(),
    builder: (context,snapshot){
      if(snapshot.hasData) {
        if (snapshot.data!.role == "STUDENT") {
          return const DashboardForStudents();
        }
        else {
          return const DashboardForLecturers();
        }
      }

      return const Center(child: CircularProgressIndicator(),);
    },
    );

  }
}

