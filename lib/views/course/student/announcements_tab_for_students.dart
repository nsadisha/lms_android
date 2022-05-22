import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lms_android/components/announcement_tile.dart';
import 'package:lms_android/components/empty_state.dart';
import 'package:lms_android/models/announcement.dart';
import 'package:lms_android/service/course_service.dart';

class AnnouncementsTabForStudents extends StatefulWidget {
  final int courseId;
  const AnnouncementsTabForStudents({Key? key, required this.courseId}) : super(key: key);

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
    await CourseService.getInstance().then((value) => setState((){
      courseService = value;
    }));
  }
  Future<List<Announcement>> fetchAnnouncements(int courseId) async {
    return await courseService.getAnnouncements(courseId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Announcement>>(
      future: fetchAnnouncements(widget.courseId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isEmpty){
            return const EmptyState(text: "No announcements",);
          }else{
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
          }
        } else if (snapshot.hasError) {
          return const EmptyState(text: "No announcements");
        }
        return const CircularProgressIndicator();
      },
    );
  }
}