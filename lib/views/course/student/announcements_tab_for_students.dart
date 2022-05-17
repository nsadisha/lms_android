import 'package:flutter/material.dart';
import 'package:lms_android/components/announcement.dart';

class AnnouncementsTabForStudents extends StatefulWidget {
  const AnnouncementsTabForStudents({Key? key}) : super(key: key);

  @override
  State<AnnouncementsTabForStudents> createState() => _AnnouncementsTabForStudentsState();
}

class _AnnouncementsTabForStudentsState extends State<AnnouncementsTabForStudents> {

  @override
  void initState(){
    super.initState();
  }

  void fetchAnnouncements(){

  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (BuildContext context, int index){
        return Announcement(
            id: index,
            title: "Hello",
            body: "hi"
        );
      },
    );
  }
}
