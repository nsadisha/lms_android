class User {

  late String email;
  late String password;
  late String name;
  late String role;
  late String cpass;
  late List<String> courses;

  User(this.email, this.password);
  User.signup(this.email, this.password, this.name, this.role, this.cpass);
  User.JWT(this.email, this.role, this.courses);
}