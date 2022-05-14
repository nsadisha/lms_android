import 'package:flutter/material.dart';

class Courses extends StatelessWidget {
  const Courses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'All courses',
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    );
  }
}