import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Session {
  Session._sharedInstance() {}
  static final Session _shared = Session._sharedInstance();

  factory Session() => _shared;

  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  Map<String, String> get cookies => headers;

  Future<Map> get(String url) async {
    final sp = await SharedPreferences.getInstance();
    final contains = sp.containsKey('cookie');
    final cookie;
    if(contains){
      final cookie = sp.getString('cookie');
      headers['cookie'] = cookie.toString();
    }

    http.Response response = await http.get(Uri.parse(url), headers: headers);

    updateCookie(response);
    return json.decode(response.body);
  }

  Future post(String url, String data) async {
    final sp = await SharedPreferences.getInstance();
    final contains = sp.containsKey('cookie');
    final cookie;
    if(contains){
      final cookie = sp.getString('cookie');
      headers['cookie'] = cookie.toString();
    }
    print(data);
    print(headers);
    http.Response response = await http.post(
      Uri.parse(url),
      body: data,
      headers: headers,
    );
    updateCookie(response);
    print(headers);
    return json.decode(response.body);
  }

  void updateCookie(http.Response response) async {
    String? rawCookie = response.headers['set-cookie'];
    final sp = await SharedPreferences.getInstance();
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      headers['cookie'] =
          (index == -1) ? rawCookie : rawCookie.substring(0, index);
      print('updatedcookie');
      print(headers['cookie']);

      String? cookie = headers['cookie'];
      sp.setString('cookie', cookie.toString());
      // sp.setString('userType','manager');

    }
  }
}
