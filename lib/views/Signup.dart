import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:lms_android/components/background.dart';
import '../models/User.dart';
import '../service/UserService.dart';

enum UserRole { student, lecturer }

class SignupView extends StatefulWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {

  @override
  void initState(){
    super.initState();
    initUserService();
  }

  UserRole? _character = UserRole.student;

  final _formKey = GlobalKey<FormState>();
  User user = User.signup("","","","STUDENT","");

  late final userService;
  void initUserService() async {
    userService = await UserService.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    navigateToLogin(){
      Navigator.pop(context);
    }

    return Scaffold(
      body: Background(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: const Text(
                    "REGISTER",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2661FA),
                        fontSize: 36
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),

                SizedBox(height: size.height * 0.02),

                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    controller: TextEditingController(text: user.email),
                    onChanged: (val) {
                      user.email = val;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email field is empty';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      errorStyle: TextStyle(fontSize: 10, color: Colors.black),
                      labelText: "Email Address"
                    ),
                  ),
                ),

                SizedBox(height: size.height * 0.02),

                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    controller: TextEditingController(text: user.name),
                    onChanged: (val) {
                      user.name = val;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Name field is empty';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      errorStyle: TextStyle(fontSize: 10, color: Colors.black),
                      labelText: "Name"
                    ),
                  ),
                ),

                SizedBox(height: size.height * 0.02),

                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        Row(
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Text('You are a',
                                style: TextStyle(
                                  fontSize: 16,
                                    color: Colors.black54,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: SizedBox(
                                height: 30.0,
                                child: ListTile(
                                  title: const Text('Student'),
                                  leading: Radio<UserRole>(
                                    value: UserRole.student,
                                    groupValue: _character,
                                    onChanged: (UserRole? value) {
                                      setState(() {
                                        _character = value;
                                        user.role = "STUDENT";
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 30.0,
                                child: ListTile(
                                  title: const Text('Lecturer'),
                                  leading: Radio<UserRole>(
                                    value: UserRole.lecturer,
                                    groupValue: _character,
                                    onChanged: (UserRole? value) {
                                      setState(() {
                                        _character = value;
                                        user.role = "LECTURER";
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                SizedBox(height: size.height * 0.02),

                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    obscureText: true,
                    controller: TextEditingController(text: user.password),
                    onChanged: (val) {
                      user.password = val;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password field is empty';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      errorStyle: TextStyle(fontSize: 10, color: Colors.black),
                      labelText: "Password"
                    ),
                  ),
                ),

                SizedBox(height: size.height * 0.02),

                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    obscureText: true,
                    controller: TextEditingController(text: user.cpass),
                    onChanged: (val) {
                      user.cpass = val;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Confirm password field is empty';
                      }else if(value!=user.password){
                        return "Password doesn't match";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        errorStyle: TextStyle(fontSize: 10, color: Colors.black),
                        labelText: "Confirm password"
                    ),
                  ),
                ),

                SizedBox(height: size.height * 0.05),

                Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Container(
                          height: 50.0,
                          width: size.width * 0.5,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80.0),
                              gradient: const LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 255, 136, 34),
                                    Color.fromARGB(255, 255, 177, 41)
                                  ]
                              )
                          ),
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.fromLTRB(75.0,15.0,75.0,15.0),
                          primary: Colors.white,
                          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                          textStyle: const TextStyle(fontSize: 14),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            var response = await userService.signup(user.email, user.name, user.role, user.password);
                            if(response.statusCode == 201){
                              navigateToLogin();
                            }else{
                              log(response.statusCode.toString());
                            }
                          }
                        },
                        child: const Text(
                          "SIGN UP",
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.symmetric(horizontal: 45, vertical: 10),
                  child: GestureDetector(
                    onTap: () => {
                      Navigator.pop(context)
                    },
                    child: const Text(
                      "Already Have an Account? Sign in",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2661FA)
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
