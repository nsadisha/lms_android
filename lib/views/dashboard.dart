import 'dart:developer';

import 'package:flutter/material.dart';

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
  }

  late final userService;


  void initUserService() async {
    userService = await UserService.getInstance();
  }

  @override
  Widget build(BuildContext context) {

    return Container();
  }
}

