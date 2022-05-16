import 'package:flutter/material.dart';
import 'package:lms_android/components/background.dart';

enum UserRole { student, lecturer }

class SignupView extends StatefulWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {

  UserRole? _character = UserRole.student;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
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
              child: const TextField(
                decoration: InputDecoration(
                    labelText: "Email Address"
                ),
              ),
            ),

            SizedBox(height: size.height * 0.02),

            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: const TextField(
                decoration: InputDecoration(
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
              child: const TextField(
                decoration: InputDecoration(
                    labelText: "Password"
                ),
              ),
            ),

            SizedBox(height: size.height * 0.02),

            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: const TextField(
                decoration: InputDecoration(
                    labelText: "Confirm password"
                ),
                obscureText: true,
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
    );
  }
}
