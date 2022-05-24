import 'package:lms_android/models/user.dart';

class Student extends User {

  late double? marks;

  Student(super.id, super.email, super.name, this.marks) : super.json();

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(json['id'], json['email'], json['name'], json['marks']);
  }
}