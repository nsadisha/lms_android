import 'package:flutter/material.dart';
import 'package:lms_android/components/announcement_tile.dart';
import 'package:lms_android/components/empty_state.dart';
import 'package:lms_android/models/announcement.dart';
import 'package:lms_android/service/course_service.dart';

class AnnouncementsTabForLectures extends StatefulWidget {
  final int courseId;
  const AnnouncementsTabForLectures({Key? key, required this.courseId}) : super(key: key);

  @override
  State<AnnouncementsTabForLectures> createState() => _AnnouncementsTabForLecturesState();
}

class _AnnouncementsTabForLecturesState extends State<AnnouncementsTabForLectures> {

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
  Future<List<Announcement>> fetchAnnouncements(int courseId) async {
    return await courseService.getAnnouncements(courseId);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: FutureBuilder<List<Announcement>>(
        future: fetchAnnouncements(widget.courseId),
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      )
    );
  }
}