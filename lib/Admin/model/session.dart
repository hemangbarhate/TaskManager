import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/ApI.dart';

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

  Future<Uint8List> getprofileImage(String apiUrl) async {
    final sp = await SharedPreferences.getInstance();
    final contains = sp.containsKey('cookie');
    final cookie;
    if(contains){
      final cookie = sp.getString('cookie');
      headers['cookie'] = cookie.toString();
    }
    var res = await http.get(Uri.parse(apiUrl), headers: headers);
    print("statusCode ${res.statusCode}");
    var image = res.bodyBytes;
    print(image.runtimeType);
    return image;
  }

  Future uploadImage1(String filename,String apiUrl) async {
    final sp = await SharedPreferences.getInstance();
    final contains = sp.containsKey('cookie');
    if(contains){
      final cookie = sp.getString('cookie');
      headers['cookie'] = cookie.toString();
    }
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    if(apiUrl == '$ip/client/profilePic'){
      request.files.add(await http.MultipartFile.fromPath('clientIcon', filename));
    }
    else if(apiUrl == '$ip/manager/profilePic'){
      request.files.add(await http.MultipartFile.fromPath('managerIcon', filename));
    }
    else if(apiUrl == '$ip/operator/profilePic'){
      request.files.add(await http.MultipartFile.fromPath('operatorIcon', filename));
    }

    request.headers['cookie'] = headers['cookie']!;
    var res = await request.send();
    res.stream.transform(utf8.decoder).listen((value) { print(value);});
    print("res ${res.statusCode}");
  }

  Future uploadProjectData(String projectName,String filename,String apiUrl) async {
    log('inside uploadprojectdata');
    final sp = await SharedPreferences.getInstance();
    final contains = sp.containsKey('cookie');
    if(contains){
      final cookie = sp.getString('cookie');
      headers['cookie'] = cookie.toString();
    }
    if(apiUrl == '$ip/admin/addDepartment'){
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      request.files.add(await http.MultipartFile.fromPath('departmentIcon', filename));
      request.files.add(await http.MultipartFile.fromString('departmentName', projectName) );
      request.headers['cookie'] = headers['cookie']!;
      var res = await request.send();
      var result = await res.stream.transform(utf8.decoder).first;
      log(result);
      return json.decode(result);
    }
    else{
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      if(filename == ''){
        log('hi$filename');
      }
      else{
        request.files.add(await http.MultipartFile.fromPath('projectIcon', filename));
      }
      request.files.add(await http.MultipartFile.fromString('projectName', projectName) );
      request.headers['cookie'] = headers['cookie']!;
      var res = await request.send();
      var result = await res.stream.transform(utf8.decoder).first;
      log(result);
      return json.decode(result);
    }

  }

  Future editData(String who,String email,String name,String password,String phone,String organization,String deptId,String filename,String apiUrl) async {
    log('inside editData $who');
    log('$filename $email $name $phone $organization $deptId $apiUrl');
    final sp = await SharedPreferences.getInstance();
    final contains = sp.containsKey('cookie');
    if(contains){
      final cookie = sp.getString('cookie');
      headers['cookie'] = cookie.toString();
    }

    if(who == 'manager') {
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

      if(filename == ''){
        log(filename);
      }
      else{
        request.files.add(await http.MultipartFile.fromPath('managerIcon', filename));
      }

      request.files.add(http.MultipartFile.fromString('name', name));
      log('hiii');
      request.files.add(http.MultipartFile.fromString('email', email));
      log('hiii');
      request.files.add(http.MultipartFile.fromString('mobile', phone));
      log('hiii');
      if(password == '' || password == 'Click to change'){
        log(password);
      }
      else{
        request.files.add(http.MultipartFile.fromString('password', password) );
      }

      request.headers['cookie'] = headers['cookie']!;
      var res = await request.send();
      print(res.statusCode);
      var result = await res.stream.transform(utf8.decoder).first;
      log(result);
      return json.decode(result);
    }
    else if(who == 'operator'){
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

      if(filename == ''){
        log(filename);
      }
      else{
        request.files.add(await http.MultipartFile.fromPath('operatorIcon', filename));
      }

      request.files.add(http.MultipartFile.fromString('name', name) );
      request.files.add(http.MultipartFile.fromString('email', email) );
      request.files.add(http.MultipartFile.fromString('mobile', phone) );
      if(password == '' || password == 'Click to change'){
        log(password);
      }
      else{
        request.files.add(http.MultipartFile.fromString('password', password) );
      }
      request.headers['cookie'] = headers['cookie']!;
      var res = await request.send();
      var result = await res.stream.transform(utf8.decoder).first;
      log(result);
      return json.decode(result);
    }
    else if(who =='client'){
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

      if(filename == ''){
        log(filename);
      }
      else{
        request.files.add(await http.MultipartFile.fromPath('clientIcon', filename));
      }
      request.files.add(await http.MultipartFile.fromString('name', name) );
      request.files.add(await http.MultipartFile.fromString('email', email) );
      request.files.add(await http.MultipartFile.fromString('mobile', phone) );
      request.files.add(await http.MultipartFile.fromString('organization', organization) );
      if(password == '' || password == 'Click to change'){
        log(password);
      }
      else{
        request.files.add(await http.MultipartFile.fromString('password', password) );
      }
      request.headers['cookie'] = headers['cookie']!;
      var res = await request.send();
      var result = await res.stream.transform(utf8.decoder).first;
      log(result);
      return json.decode(result);
    }
    else if(who =='department'){
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

      if(filename == ''){
        log(filename);
      }
      else{
        request.files.add(await http.MultipartFile.fromPath('departmentIcon', filename));
      }
      request.files.add(await http.MultipartFile.fromString('departmentName', name) );
      request.headers['cookie'] = headers['cookie']!;
      var res = await request.send();
      var result = await res.stream.transform(utf8.decoder).first;
      log(result);
      return json.decode(result);
    }

    return 'manager';
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
