import 'dart:developer';

import 'package:flutter/material.dart';

import '../service/UserService.dart';

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
                            Text('Hello', style: TextStyle(fontFamily: 'Mukta',fontSize: 30)),
                            Text('Devid decor', style: TextStyle(fontFamily: 'Mukta',fontSize: 30)),
                            Text('Welcome Back!', style: TextStyle(fontFamily: 'Mukta',fontSize: 25,color: Colors.grey))

                          ],
                        ),
                        SizedBox(width: 80,),
                        Container(
                          width: 70,
                          height: 70,
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/images/graduate.png'),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}



