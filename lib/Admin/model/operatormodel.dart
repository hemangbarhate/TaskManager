// To parse this JSON data, do
//
//     final clientmodel = clientmodelFromJson(jsonString);

import 'dart:convert';

Clientmodel clientmodelFromJson(String str) => Clientmodel.fromJson(json.decode(str));

String clientmodelToJson(Clientmodel data) => json.encode(data.toJson());

class Clientmodel {
  Clientmodel({
    required this.success,
    required this.data,
  });

  bool success;
  List<Datum> data;

  factory Clientmodel.fromJson(Map<String, dynamic> json) => Clientmodel(
    success: json["success"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.operatorId,
    required this.name,
    required this.email,
    required this.mobile,
    required this.password,
    required this.departmentId,
  });

  String operatorId;
  String name;
  String email;
  String mobile;
  String password;
  String departmentId;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    operatorId: json["operatorId"],
    name: json["name"],
    email: json["email"],
    mobile: json["mobile"],
    password: json["password"],
    departmentId: json["departmentId"],
  );

  Map<String, dynamic> toJson() => {
    "operatorId": operatorId,
    "name": name,
    "email": email,
    "mobile": mobile,
    "password": password,
    "departmentId": departmentId,
  };
}
