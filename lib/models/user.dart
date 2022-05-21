
class User {

  late int id;
  late String email;
  late String password;
  late String name;
  late String role;
  late String cpass;
  late double? marks;
  late List<String> courses;

  User(this.email, this.password);
  User.signup(this.email, this.password, this.name, this.role, this.cpass);
  User.jwt(this.id, this.email, this.role, this.courses);
  User.json(this.id, this.email, this.name);
  User.marks(this.id, this.email, this.name, this.marks);

  factory User.fromJson(Map<String, dynamic> json) {
    return User.json(json['id'], json['email'], json['name']);
  }

  factory User.marksFromJson(Map<String, dynamic> json) {
    return User.marks(json['id'], json['email'], json['name'], json['marks']);
  }
}