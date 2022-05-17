import 'package:flutter/material.dart';
import 'package:lms_android/components/empty_state.dart';
import 'package:lms_android/views/course/student/activity_tab_for_students.dart';
import 'package:lms_android/views/course/student/announcements_tab_for_students.dart';

class CourseDetails extends StatefulWidget {
  final int courseId;
  const CourseDetails({Key? key, required this.courseId}) : super(key: key);
  //CourseDetails(this.courseId);

  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {

  final List<Tab> myTabs = <Tab>[
    const Tab(text: 'Activity', icon: Icon(Icons.local_activity), iconMargin: EdgeInsets.only(bottom: 10),),
    const Tab(text: 'Announcements', icon: Icon(Icons.announcement),),
    const Tab(text: 'Details', icon: Icon(Icons.details),),
    const Tab(text: 'Marks', icon: Icon(Icons.edit))
  ];

  List<Widget> tabViewsForStudents = [
    const ActivityTabForStudents(),
    const AnnouncementsTabForStudents(),
    const EmptyState(text: "No activity details"),
    const EmptyState(text: "No activity marks"),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Software Construction"),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
          bottom: TabBar(
            tabs: myTabs,
          ),
        ),
        body: TabBarView(
          children: tabViewsForStudents,
        ),
      ),
    );
  }
}
