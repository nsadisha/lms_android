import 'package:flutter/material.dart';
import 'package:lms_android/components/student_marks_card.dart';
import 'package:lms_android/models/user.dart';
import 'package:lms_android/service/lecturer_service.dart';

class MarksTabForLecturers extends StatefulWidget {
  final int courseId;
  const MarksTabForLecturers({Key? key, required this.courseId}) : super(key: key);

  @override
  State<MarksTabForLecturers> createState() => _MarksTabForLecturersState();
}

class _MarksTabForLecturersState extends State<MarksTabForLecturers> {

  late final LecturerService lecturerService;

  @override
  void initState(){
    super.initState();
    initLecturerService();
  }

  void initLecturerService() async {
    await LecturerService.getInstance().then((value) => setState((){
      lecturerService = value;
    }));
  }

  Future<List<User>> getEnrolledStudentMarks() async {
    return await lecturerService.getEnrolledStudentsMarks(widget.courseId);
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<User>>(
        future: getEnrolledStudentMarks(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (BuildContext context, int index){

                  int id = snapshot.data!.elementAt(index).id;
                  String name = snapshot.data!.elementAt(index).name;
                  String email = snapshot.data!.elementAt(index).email;
                  double? marks = snapshot.data!.elementAt(index).marks;

                  return StudentMarksCard(
                      student: User.marks(id, email, name, marks),
                     courseId: widget.courseId,
                  );
                });
          }else if (snapshot.hasError) {
            return const Text("Error");
          }
          return const CircularProgressIndicator();
          },
       );
  }
}