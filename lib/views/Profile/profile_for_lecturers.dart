import 'package:flutter/material.dart';
import 'package:lms_android/models/user.dart';
import 'package:lms_android/service/lecturer_service.dart';
import 'package:lms_android/service/student_service.dart';
import 'package:lms_android/service/user_service.dart';

class ProfileForLecturers extends StatefulWidget {
  const ProfileForLecturers({Key? key}) : super(key: key);

  @override
  State<ProfileForLecturers> createState() => _ProfileForLecturers();
}

class _ProfileForLecturers extends State<ProfileForLecturers> {
  @override
  void initState(){
    super.initState();
    initServices();
  }

  late final UserService userService;
  late final LecturerService lecturerService;

  late final User user ;

  void initServices() async {
    await UserService.getInstance().then((value) => setState((){
      userService = value;
    }));
    await LecturerService.getInstance().then((value) => setState((){
      lecturerService = value;
    }));
    await userService.getUserDetails().then((value) => setState((){
      user = value;
    }));
  }

  Future<User> getUser() async{
    return await lecturerService.getLecturerDetails(user.id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 25),
      child: FutureBuilder<User>(
          future: getUser(),
          builder: (context,snapshot) {

            if(snapshot.hasData){
              return Column(
                children: [
                  Text("Profile", style: Theme.of(context).textTheme.headline4,),
                  SizedBox(height: 50,),
                  Container(
                    width: 150,
                    height: 150,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage('assets/images/teacher.png')
                        )
                    ),
                  ),
                  SizedBox(height: 30,),
                  Text(snapshot.data!.name,style: Theme.of(context).textTheme.headline5),
                  Text(snapshot.data!.email, style: Theme.of(context).textTheme.bodyMedium,),
                  Expanded(child: Container(),),
                  ElevatedButton(onPressed: (){return userService.signout();}, child: Text("Signout"))
                ],

              );

            }
            if(snapshot.hasError){
              return const Center(
                child: Text(
                    "Something went wrong!"
                ),
              );
            }
            return Center(child: CircularProgressIndicator());

          }
      ),
    );
  }
}