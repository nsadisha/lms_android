import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'User Profile',
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    );
  }
}