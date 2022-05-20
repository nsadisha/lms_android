import 'package:flutter/material.dart';
import 'package:lms_android/components/empty_state.dart';
import 'package:lms_android/models/course.dart';
import 'package:lms_android/views/course/lecturer/activity_tab_for_lecturers.dart';
import 'package:lms_android/views/course/lecturer/announcements_tab_for_lecturers.dart';
import 'package:lms_android/views/course/lecturer/details_tab_for_lecturers.dart';
import 'package:lms_android/views/course/student/activity_tab_for_students.dart';
import 'package:lms_android/views/course/student/announcements_tab_for_students.dart';
import 'course/student/details_tab_for_students.dart';

class CourseContent extends StatefulWidget {
  final Course course;
  final bool isStudent;
  final int userId;

  const CourseContent ({Key? key, required this.course, required this.isStudent, required this.userId}) : super(key: key);

  @override
  State<CourseContent> createState() => _CourseContentState();

}

class _CourseContentState extends State<CourseContent> {

  final List<Tab> myTabs = <Tab>[
    const Tab(text: 'Activity', icon: Icon(Icons.local_activity)),
    const Tab(text: 'Announcements', icon: Icon(Icons.announcement),),
    const Tab(text: 'Details', icon: Icon(Icons.details),),
    const Tab(text: 'Marks', icon: Icon(Icons.edit))
  ];

  @override
  Widget build(BuildContext context) {

    List<Widget> tabViewsForStudents = [
      const ActivityTabForStudents(),
      AnnouncementsTabForStudents(courseId: widget.course.id),
      DetailsTabForStudents(course: widget.course, userId: widget.userId),
    ];

    List<Widget> tabViewsForLecturers = [
      const ActivityTabForLecturers(),
      AnnouncementsTabForLecturers(course: widget.course),
      DetailsTabForLecturers(course: widget.course),
      const EmptyState(text: "No activity marks"),
    ];

    return DefaultTabController(
      length: widget.isStudent ? tabViewsForStudents.length : tabViewsForLecturers.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.course.courseName),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
          bottom: TabBar(
            tabs: widget.isStudent ?
                  myTabs.take(tabViewsForStudents.length).toList() :
                  myTabs.take(tabViewsForLecturers.length).toList(),
          ),
        ),
        body: TabBarView(
          children: widget.isStudent ? tabViewsForStudents : tabViewsForLecturers
        ),
      ),
    );
  }
}
