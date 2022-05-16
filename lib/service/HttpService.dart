import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../models/User.dart';

class HttpService {

  final String loginURL = "http://192.168.8.182:8090/login";

  Future signin(String email, String password) async {
    log(Uri.parse(loginURL).toString());
    final res = await http.post(
      Uri.parse(loginURL),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      encoding: Encoding.getByName('utf-8'),
      body: {
        "email": email,
        "password": password
      },
    );
    if (res.statusCode == 200) {
      final obj = jsonDecode(res.body);
      log('sucess$obj');
    } else {
      throw "Unable to retrieve user";
    }
  }

}
