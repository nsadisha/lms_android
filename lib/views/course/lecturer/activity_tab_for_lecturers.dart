import 'package:flutter/material.dart';
import 'package:lms_android/components/empty_state.dart';

class ActivityTabForLecturers extends StatelessWidget {
  const ActivityTabForLecturers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: const EmptyState(text: "No activity"),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.blue,
          child: const Icon(Icons.add),
        ),);
  }
}