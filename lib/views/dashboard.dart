import 'package:flutter/material.dart';
import 'package:lms_android/models/User.dart';
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
    initUserService();
    getUserRole();
  }

  late final UserService userService;
  late final String userRole = "STUENT";

  void initUserService() async {
    userService = await UserService.getInstance();
  }

  Future getUserRole() async {
    User user = (await userService.getUserDetails()) as User;
    //userRole=user.role;
  }


  @override
  Widget build(BuildContext context) {
    if(userRole == "STUDENT"){
      return const DashboardForStudents();
    }
    else{
      return const DashboardForLecturers();
    }

  }
}

