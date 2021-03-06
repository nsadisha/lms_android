import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lms_android/service/user_service.dart';
import '../components/background.dart';
import '../models/user.dart';


class SigninView extends StatefulWidget {
  const SigninView({Key? key}) : super(key: key);

  @override
  State<SigninView> createState() => _SigninViewState();
}

class _SigninViewState extends State<SigninView> {

  @override
  void initState(){
    super.initState();
    initUserService();
  }

  late final UserService userService;
  final _formKey = GlobalKey<FormState>();
  User user = User("", "");

  void initUserService() async {
    await UserService.getInstance().then((value) => setState((){
      userService = value;
    }));
  }

  Future<bool> isSigned() async {
    return await userService.isSigned();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    navigateToHome(){
      Navigator.pushNamed(context, '/');
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
                    "LOGIN",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2661FA),
                        fontSize: 36
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),

                SizedBox(height: size.height * 0.03),

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
                        return 'Email field is Empty';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      errorStyle: TextStyle(fontSize: 10, color: Colors.black),
                      labelText: "Email Address",
                    ),
                  ),
                ),

                SizedBox(height: size.height * 0.03),

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
                        return 'Password field is Empty';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        errorStyle: TextStyle(fontSize: 10, color: Colors.black),
                        labelText: "Password"
                    ),
                  ),
                ),

                Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: const Text(
                    "Forgot your password?",
                    style: TextStyle(
                        fontSize: 12,
                        color: Color(0XFF2661FA)
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
                            var response = await userService.signin(user.email, user.password);
                            if(response.statusCode == 200){
                              navigateToHome();
                            }else{
                              log(response.statusCode.toString());
                            }
                          }
                        },
                        child: const Text(
                          "LOGIN",
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
                      Navigator.pushNamed(context, '/signup')
                    },
                    child: const Text(
                      "Don't Have an Account? Sign up",
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
