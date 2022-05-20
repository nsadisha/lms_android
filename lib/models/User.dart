class User {

  String email;
  String password;
  late String name;
  late String role;
  late String cpass;
  late int id;

  User(this.email, this.password);
  User.signup(this.email, this.password, this.name, this.role, this.cpass);
}