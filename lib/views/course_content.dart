import 'package:flutter/material.dart';
import 'package:lms_android/components/empty_state.dart';
import 'package:lms_android/models/course.dart';
import 'package:lms_android/views/course/student/activity_tab_for_students.dart';
import 'package:lms_android/views/course/student/announcements_tab_for_students.dart';
import '../service/course_service.dart';
import 'course/student/details_tab_for_students.dart';

class CourseContent extends StatefulWidget {

  const CourseContent ({Key? key}) : super(key: key);

  @override
  State<CourseContent> createState() => _CourseContentState();

}

class _CourseContentState extends State<CourseContent> {

  late final CourseService courseService;

  @override
  void initState(){
    super.initState();
    initCourseService();
  }

  void initCourseService() async {
    await CourseService.getInstance().then((value) => setState((){
      courseService = value;
    }));
  }

  final List<Tab> myTabs = <Tab>[
    const Tab(text: 'Activity', icon: Icon(Icons.local_activity), iconMargin: EdgeInsets.only(bottom: 10),),
    const Tab(text: 'Announcements', icon: Icon(Icons.announcement),),
    const Tab(text: 'Details', icon: Icon(Icons.details),),
    const Tab(text: 'Marks', icon: Icon(Icons.edit))
  ];

  @override
  Widget build(BuildContext context) {

    final courseId = ModalRoute.of(context)!.settings.arguments as int;

    Future<Course> fetchCourse() async {
      return await courseService.getCourseDetails(courseId);
    }

    List<Widget> tabViewsForStudents = [
      const ActivityTabForStudents(),
      AnnouncementsTabForStudents(courseId: courseId),
      const EmptyState(text: "No activity details"),
      const EmptyState(text: "No activity marks"),
    ];

    return FutureBuilder<Course>(
            future: fetchCourse(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return DefaultTabController(
                  length: myTabs.length,
                  child: Scaffold(
                    appBar: AppBar(
                      title: Text(snapshot.data!.courseName),
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
                    children: [
                      const ActivityTabForStudents(),
                      AnnouncementsTabForStudents(courseId: courseId),
                      DetailsTabForStudents(course: snapshot.data!),
                      const EmptyState(text: "No activity marks")],
                    ),
                  ),
                );
              }else if (snapshot.hasError) {
                return const EmptyState(text: "Course not found",);
              }
              return const CircularProgressIndicator();
            }
          );
  }
}
