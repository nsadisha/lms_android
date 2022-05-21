import 'package:flutter/material.dart';
import 'package:lms_android/components/empty_state.dart';

class ActivityTabForStudents extends StatelessWidget {
  const ActivityTabForStudents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const EmptyState(text: "No activity");
  }
}
