// To parse this JSON data, do
//
//     final managermodel = managermodelFromJson(jsonString);

import 'dart:convert';

Managermodel managermodelFromJson(String str) => Managermodel.fromJson(json.decode(str));

String managermodelToJson(Managermodel data) => json.encode(data.toJson());

class Managermodel {
  Managermodel({
    required this.success,
    required this.data,
  });

  bool success;
  List<Datum> data;

  factory Managermodel.fromJson(Map<String, dynamic> json) => Managermodel(
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
    required this.managerId,
    required this.name,
    required this.email,
    required this.mobile,
    required this.password,
  });

  String managerId;
  String name;
  String email;
  String mobile;
  String password;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    managerId: json["managerId"],
    name: json["name"],
    email: json["email"],
    mobile: json["mobile"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "managerId": managerId,
    "name": name,
    "email": email,
    "mobile": mobile,
    "password": password,
  };
}
