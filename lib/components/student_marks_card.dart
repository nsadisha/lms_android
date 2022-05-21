import 'package:flutter/material.dart';
import '../models/user.dart';

class StudentMarksCard extends StatefulWidget {

  final User student;

  const StudentMarksCard({
    Key? key, required this.student}) : super(key: key);

  @override
  State<StudentMarksCard> createState() => _StudentMarksCardState();
}

class _StudentMarksCardState extends State<StudentMarksCard> {
  @override
  Widget build(BuildContext context) {

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
                  Text(
                    'Change Marks',
                    style: TextStyle(color: Colors.blue.withOpacity(0.6)),
                  ),
                ],
              ),
              onPressed: (){
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
                    Text(
                      '${widget.student.marks} %',
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}