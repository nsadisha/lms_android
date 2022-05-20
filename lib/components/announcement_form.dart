import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:lms_android/service/course_service.dart';
import '../models/announcement.dart';
import '../models/course.dart';

class AnnouncementForm extends StatefulWidget {
  final Course course;
  const AnnouncementForm({Key? key, required this.course}) : super(key: key);

  @override
  State<AnnouncementForm> createState() => _AnnouncementFormState();
}

class _AnnouncementFormState extends State<AnnouncementForm> {

  late final CourseService courseService;
  final formKey = GlobalKey<FormState>();
  Announcement announcement = Announcement("", "");

  @override
  void initState(){
    super.initState();
    initCourseService();
  }

  void initCourseService() async {
    courseService = await CourseService.getInstance();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    navigateBack(){
      Navigator.pop(context, true);
    }

    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            SizedBox(height: size.height * 0.03),

            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  const Text(
                    "Post an Announcement",
                    style: TextStyle(fontSize: 24,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      "Course: ${widget.course.courseName}",
                      style: const TextStyle(fontSize: 14,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    widget.course.courseCode,
                    style: const TextStyle(fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            SizedBox(height: size.height * 0.02),

            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                controller: TextEditingController(text: announcement.title),
                onChanged: (val) {
                  announcement.title = val;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Title is Empty';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  errorStyle: TextStyle(fontSize: 10, color: Colors.black),
                  labelText: "Title",
                ),
              ),
            ),

            SizedBox(height: size.height * 0.03),

            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                controller: TextEditingController(text: announcement.body),
                onChanged: (val) {
                  announcement.body = val;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Message is Empty';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    errorStyle: TextStyle(fontSize: 10, color: Colors.black),
                    labelText: "Message"
                ),
              ),
            ),

            SizedBox(height: size.height * 0.03),

            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Container(
                      height: 50.0,
                      width: size.width * 0.5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80.0),
                          gradient: const LinearGradient(
                              colors: [
                                Color.fromARGB(255, 255, 136, 34),
                                Color.fromARGB(255, 255, 177, 41)
                              ]
                          )
                      ),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(75.0,15.0,75.0,15.0),
                      primary: Colors.white,
                      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                      textStyle: const TextStyle(fontSize: 14),
                    ),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        var response = await courseService.postAnnouncement(
                            widget.course.id,
                            announcement.title,
                            announcement.body);
                        if(response.statusCode == 200){
                          navigateBack();
                        }else{
                          log(response.statusCode.toString());
                        }
                      }
                    },
                    child: const Text(
                      "SUBMIT",
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}