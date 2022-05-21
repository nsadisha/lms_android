import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lms_android/service/lecturer_service.dart';
import '../models/user.dart';

class StudentMarksCard extends StatefulWidget {

  final User student;
  final int courseId;

  const StudentMarksCard({
    Key? key, required this.student, required this.courseId}) : super(key: key);

  @override
  State<StudentMarksCard> createState() => _StudentMarksCardState();
}

class _StudentMarksCardState extends State<StudentMarksCard> {

  late final LecturerService lecturerService;
  final formKey = GlobalKey<FormState>();

  @override
  void initState(){
    super.initState();
    initLecturerService();
  }

  void initLecturerService() async {
    lecturerService = await LecturerService.getInstance();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    navigateBack(){
      Navigator.pop(context, true);
    }

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 4.0,
      child: Column(
        children: [
          ListTile(
            title: Text(widget.student.name),
            subtitle: Text(
              widget.student.email,
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
            trailing: TextButton(
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.only(top: 6),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap),
              child: Column(
                children: [
                  const Icon(Icons.arrow_forward),
                  widget.student.marks != null ? Text(
                    'Change Marks',
                    style: TextStyle(color: Colors.blue.withOpacity(0.6)),
                  ):
                  Text(
                    'Add Marks',
                    style: TextStyle(color: Colors.blue.withOpacity(0.6)),
                  ),
                ],
              ),
              onPressed: (){
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      elevation: 16,
                      child: SizedBox(
                          height: 250.0,
                          width: 360.0,
                          child: Form(
                            key: formKey,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[

                                  SizedBox(height: size.height * 0.03),

                                  Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(horizontal: 50),
                                    child: Column(
                                      children: [
                                        widget.student.marks != null ? const Text(
                                          "Change Marks",
                                          style: TextStyle(fontSize: 24,
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ):
                                        const Text(
                                          "Add Marks",
                                          style: TextStyle(fontSize: 24,
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 5),
                                          child: Text(
                                            "Student: ${widget.student.name}",
                                            style: const TextStyle(fontSize: 14,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(height: size.height * 0.02),

                                  Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.symmetric(horizontal: 40),
                                    child: TextFormField(
                                      controller: TextEditingController(
                                          text: widget.student.marks != null ?
                                          widget.student.marks.toString() : ""),
                                      onChanged: (val) {
                                        widget.student.marks = double.tryParse(val);
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Marks field is Empty';
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                        errorStyle: TextStyle(fontSize: 10, color: Colors.black),
                                        labelText: "Marks",
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
                                              var response = await lecturerService.assignMarksToStudent(
                                                  widget.courseId,
                                                  widget.student.id,
                                                  widget.student.marks!);
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
                          )
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
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1)
            ),
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5.0, left: 16.0, right: 35.0, top: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Marks :',
                      style: TextStyle(color: Colors.black),
                    ),
                    widget.student.marks != null ?Text(
                      '${widget.student.marks} %',
                      style: const TextStyle(color: Colors.black),
                    ):
                    const Text(
                      'Not assigned yet',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                )
              ),
            ),
          ),
        ],
      ),
    );
  }
}