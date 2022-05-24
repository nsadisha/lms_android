import 'package:flutter/material.dart';
import 'package:lms_android/models/user.dart';
import 'package:lms_android/service/lecturer_service.dart';
import 'package:lms_android/service/user_service.dart';

import '../signin.dart';

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

  Future<void> signout() async {
    await userService.signout();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 25),
      child: FutureBuilder<User>(
          future: getUser(),
          builder: (context,snapshot) {

            if(snapshot.hasData){
              return Column(
                children: [
                  Text("Lecturer", style: Theme.of(context).textTheme.headline4,),
                  const SizedBox(height: 50,),
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
                  const SizedBox(height: 30,),
                  Text(snapshot.data!.name,style: Theme.of(context).textTheme.headline5),
                  Text(snapshot.data!.email, style: Theme.of(context).textTheme.bodyMedium,),
                  Container(
                    padding: EdgeInsets.only(top: 30.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.grey
                        ),
                        onPressed: (){
                          signout().then((value) => {
                            //Navigator.popUntil(context, ModalRoute.withName('/login'))
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const SigninView() ))
                          });
                        },
                        child: const Text("Signout")
                    ),
                  )
                ],

              );

            }
            else if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child:CircularProgressIndicator());
            }
            else {
              return const Center(child:CircularProgressIndicator());
            }
          }
      ),
    );
  }
}