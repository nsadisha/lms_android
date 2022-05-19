import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                    height: 180,
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
                        SizedBox(width:100,),
                        Container(
                          width: 70,
                          height: 70,
                          child: (
                            Image(image: AssetImage('assets/images/graduate.png'))
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 60,
                    child: Row(
                      children: <Widget>[
                        Text('Enrolled Courses',style: TextStyle(fontFamily: 'Mukta',fontSize: 30))
                      ],
                    ),
                  ),
                  Expanded(child: GridView.count(
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    primary: false,
                    children: <Widget>[
                      Card(
                        child: Column(
                          children: <Widget>[
                            Text('data')
                          ],
                        ),
                      ),
                      Card(
                        child: Column(
                          children: <Widget>[
                            Text('data', style: TextStyle(fontFamily: 'Mukta',fontSize: 30))
                          ],
                        ),
                      ),
                    ],
                    crossAxisCount: 2,))

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}



