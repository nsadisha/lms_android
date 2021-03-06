import 'package:flutter/material.dart';
import 'package:lms_android/components/announcement_form.dart';
import 'package:lms_android/components/announcement_tile.dart';
import 'package:lms_android/components/empty_state.dart';
import 'package:lms_android/models/announcement.dart';
import 'package:lms_android/models/course.dart';
import 'package:lms_android/service/course_service.dart';

class AnnouncementsTabForLecturers extends StatefulWidget {
  final Course course;
  const AnnouncementsTabForLecturers({Key? key, required this.course}) : super(key: key);

  @override
  State<AnnouncementsTabForLecturers> createState() => _AnnouncementsTabForLecturersState();
}

class _AnnouncementsTabForLecturersState extends State<AnnouncementsTabForLecturers> {

  late final CourseService courseService;
  Announcement announcement = Announcement(" ", " ");

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
        future: fetchAnnouncements(widget.course.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty){
              return const EmptyState(text: "No announcements",);
            }else {
              return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (BuildContext context, int index) {
                    int id = snapshot.data!.elementAt(index).id;
                    String title = snapshot.data!.elementAt(index).title;
                    String body = snapshot.data!.elementAt(index).body;

                    return AnnouncementTile(
                        id: id,
                        title: title,
                        body: body
                    );
                  });
            }
          } else if (snapshot.hasError) {
            return const EmptyState(text: "No announcements",);
          }

          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                elevation: 16,
                child: SizedBox(
                    height: 400.0,
                    width: 360.0,
                    child: AnnouncementForm(course: widget.course)
                ),
              );
            },
          ).then((exit) {
            if (exit == null) return;
            if (exit) {
              setState(() {});
            }
          });
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      )
    );
  }
}