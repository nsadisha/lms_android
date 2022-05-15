import 'package:flutter/material.dart';

class CourseDetails extends StatefulWidget {
  final int courseId;
  const CourseDetails({Key? key, required this.courseId}) : super(key: key);
  //CourseDetails(this.courseId);

  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {

  final List<Tab> myTabs = <Tab>[
    const Tab(text: 'Activity', icon: Icon(Icons.local_activity), iconMargin: EdgeInsets.only(bottom: 10),),
    const Tab(text: 'Announcements', icon: Icon(Icons.announcement),),
    const Tab(text: 'Details', icon: Icon(Icons.details),),
    const Tab(text: 'Marks', icon: Icon(Icons.edit))
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Software Construction"),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
          bottom: TabBar(
            tabs: myTabs,
          ),
        ),
        body: Container(
          child: TabBarView(
            children: myTabs.map((Tab tab) {
              final String? label = tab.text?.toLowerCase();
              return Center(
                child: Text(
                  'This is the $label tab',
                  style: const TextStyle(fontSize: 36),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
