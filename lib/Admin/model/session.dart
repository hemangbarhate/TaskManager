import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class Session {
  Session._sharedInstance();
  static final Session _shared = Session._sharedInstance();

  factory Session()=>_shared;

  Map<String, String> headers = {'Content-Type': 'application/json; charset=UTF-8',};

  Map<String,String> get cookies =>headers;

  Future<dynamic> get2(String url) async {
    http.Response response = await http.get(Uri.parse(url), headers: headers);
    updateCookie(response);
    print(response.body);
    return response;
  }

  Future<Map> get(String url) async {
    http.Response response = await http.get(Uri.parse(url), headers: headers);
    updateCookie(response);
    return json.decode(response.body);
  }

  Future post(String url, String data) async {
    print(data);
    print(headers);
    http.Response response = await http.post(Uri.parse(url), body: data, headers: headers,);
    updateCookie(response);
    print(headers);
      return json.decode(response.body);
  }

  void updateCookie(http.Response response) {
    String? rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      headers['cookie'] =
      (index == -1) ? rawCookie : rawCookie.substring(0, index);
      print('updatedcookie');
      print(headers['cookie']);
    }
  }
}