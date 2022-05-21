import 'package:flutter/material.dart';

class AnnouncementTile extends StatelessWidget {
  final int id;
  final String title;
  final String body;

  const AnnouncementTile({Key? key, required this.id, required this.title, required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(title),
      children: [Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(right: 20, left: 20, bottom: 10),
            child: Text(body),
          )
      )],
    );
  }
}
