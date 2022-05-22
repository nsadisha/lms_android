import 'package:flutter/material.dart';
import 'package:lms_android/models/user.dart';
import 'package:lms_android/service/student_service.dart';
import 'package:lms_android/service/user_service.dart';

class ProfileForStudents extends StatefulWidget {
  const ProfileForStudents({Key? key}) : super(key: key);

  @override
  State<ProfileForStudents> createState() => _ProfileForStudents();
}

class _ProfileForStudents extends State<ProfileForStudents> {
  @override
  void initState(){
    super.initState();
    initServices();
  }

  late final UserService userService;
  late final StudentService studentService;

  late final User user ;

  void initServices() async {
    await UserService.getInstance().then((value) => setState((){
      userService = value;
    }));
    await StudentService.getInstance().then((value) => setState((){
      studentService = value;
    }));
    await userService.getUserDetails().then((value) => setState((){
      user = value;
    }));
  }

  Future<User> getUser() async{
    return await studentService.getStudentDetails(user.id);
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
                  Text("Profile", style: Theme.of(context).textTheme.headline4,),
                  const SizedBox(height: 50,),
                  Container(
                    width: 150,
                    height: 150,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage('assets/images/graduate.png')
                        )
                    ),
                  ),
                  const SizedBox(height: 30,),
                  Text(snapshot.data!.name,style: Theme.of(context).textTheme.headline5),
                  Text(snapshot.data!.email, style: Theme.of(context).textTheme.bodyMedium,),
                  Expanded(child: Container(),),
                  ElevatedButton(
                      onPressed: (){
                    signout().then((value) => {
                      Navigator.pushNamed(context, '/login')
                    });
                    },
                      child: const Text("Signout"))
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
            return const Center(child: CircularProgressIndicator());

          }
      ),
    );
  }
}