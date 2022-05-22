import 'package:flutter/material.dart';
import 'package:lms_android/models/user.dart';
import 'package:lms_android/service/user_service.dart';
import 'package:lms_android/views/Profile/profile_for_lecturers.dart';
import 'package:lms_android/views/Profile/profile_for_students.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _Profile();
}

class _Profile extends State<Profile> {

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
            return const ProfileForStudents();
          }
          else {
            return const ProfileForLecturers();
          }
        }

        return const Center(child: CircularProgressIndicator(),);
      },
    );

  }
}

