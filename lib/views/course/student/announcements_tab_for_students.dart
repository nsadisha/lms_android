import 'package:flutter/material.dart';
import 'package:lms_android/components/announcement_tile.dart';
import 'package:lms_android/components/empty_state.dart';
import 'package:lms_android/models/announcement.dart';
import 'package:lms_android/service/course_service.dart';

class AnnouncementsTabForStudents extends StatefulWidget {
  const AnnouncementsTabForStudents({Key? key}) : super(key: key);

  @override
  State<AnnouncementsTabForStudents> createState() => _AnnouncementsTabForStudentsState();
}

class _AnnouncementsTabForStudentsState extends State<AnnouncementsTabForStudents> {

  late final CourseService courseService;

  @override
  void initState(){
    super.initState();
    initCourseService();
  }

  void initCourseService() async {
    setState(()async{
      courseService = await CourseService.getInstance();
    });
  }
  Future<List<Announcement>> fetchAnnouncements(int courseId) async {
    return await courseService.getAnnouncements(courseId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Announcement>>(
      future: fetchAnnouncements(4),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (BuildContext context, int index){

              int id = snapshot.data!.elementAt(index).id;
              String title = snapshot.data!.elementAt(index).title;
              String body = snapshot.data!.elementAt(index).body;

              return AnnouncementTile(
                  id: id,
                  title: title,
                  body: body
              );
            });
        } else if (snapshot.hasError) {
          return const EmptyState(text: "No announcements",);
        }

        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }
}