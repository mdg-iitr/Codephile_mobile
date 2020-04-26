import 'dart:convert';
import 'package:codephile/models/signup.dart';
import 'package:http/http.dart' as http;
import 'package:codephile/resources/strings.dart';

var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<int> signUp(SignUp details) async {
  String endpoint = "/user/signup";
  String uri = url + endpoint;
  print(uri);
  print('before try');
  print(details.username);
  print(details.password);
  print(details.fullname);
  print(details.institute == null);
  print(details.handle.codechef == null);
  print("codeforces ${details.handle.codeforces}");
  print("hackerrank ${details.handle.hackerrank}");
  print("spoj ${details.handle.spoj}");

  try {
    var response = await client.post(
      uri,
      body: {
        "username" : details.username,
        "password" : details.password,
        "fullname": details.fullname,
        "institute": details.institute,
        "handle.codechef": details.handle.codechef,
        "handle.codeforces": details.handle.codeforces,
        "handle.hackerrank": details.handle.hackerrank,
        "handle.spoj": details.handle.spoj
      },
    );
    print('after try');
    print(response.statusCode);

    return response.statusCode;

  } on Exception catch (e) {
    print(e);
    return null;
  }
}