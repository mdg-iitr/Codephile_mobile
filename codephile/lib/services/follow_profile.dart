import 'dart:io';
import 'package:codephile/resources/strings.dart';
import 'package:http/http.dart' as http;

var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<int> followUser (String token, String uid) async{
  String endpoint = "/follow/following?uid2=$uid";
  String uri = url + endpoint;

  var tokenAuth = {HttpHeaders.authorizationHeader: token};

  try{
    var response = await client.get(
      uri,
      headers: tokenAuth,
    );
    return response.statusCode;
  }on Exception catch(e){
    print(e);
    return null;
  }
}
