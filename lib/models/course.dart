class Course {
  final int id;
  final String courseName;
  final String courseCode;
  final String lecturerName;
  final String description;

  const Course( {
    required this.id,
    required this.courseName,
    required this.courseCode,
    required this.lecturerName,
    required this.description
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['course_id'],
      courseName: json['name'],
      courseCode: json['course_code'],
      lecturerName: json['lecturer']['name'],
      description: json['description']
    );
  }
}