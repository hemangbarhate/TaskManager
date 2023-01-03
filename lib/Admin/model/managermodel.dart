// // To parse this JSON data, do
// //
// //     final managermodel = managermodelFromJson(jsonString);
//
// import 'dart:convert';
//
// Managermodel managermodelFromJson(String str) => Managermodel.fromJson(json.decode(str));
//
// String managermodelToJson(Managermodel data) => json.encode(data.toJson());
//
// class Managermodel {
//   Managermodel({
//     required this.success,
//     required this.data,
//   });
//
//   bool success;
//   List<Datum> data;
//
//   factory Managermodel.fromJson(Map<String, dynamic> json) => Managermodel(
//     success: json["success"],
//     data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "success": success,
//     "data": List<dynamic>.from(data.map((x) => x.toJson())),
//   };
// }
//
// class Datum {
//   Datum({
//     required this.managerId,
//     required this.name,
//     required this.email,
//     required this.mobile,
//     required this.password,
//   });
//
//   String managerId;
//   String name;
//   String email;
//   String mobile;
//   String password;
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//     managerId: json["managerId"],
//     name: json["name"],
//     email: json["email"],
//     mobile: json["mobile"],
//     password: json["password"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "managerId": managerId,
//     "name": name,
//     "email": email,
//     "mobile": mobile,
//     "password": password,
//   };
// }
// To parse this JSON data, do
//
//     final mandata = mandataFromJson(jsonString);
//
// import 'dart:convert';
//
// Mandata mandataFromJson(String str) => Mandata.fromJson(json.decode(str));
//
// String mandataToJson(Mandata data) => json.encode(data.toJson());
//
// class Mandata {
//   Mandata({
//     required this.managerId,
//     required this.name,
//     required this.email,
//     required this.mobile,
//     required this.password,
//   });
//
//   String managerId;
//   String name;
//   String email;
//   String mobile;
//   String password;
//
//   factory Mandata.fromJson(Map<String, dynamic> json) => Mandata(
//     managerId: json["managerId"],
//     name: json["name"],
//     email: json["email"],
//     mobile: json["mobile"],
//     password: json["password"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "managerId": managerId,
//     "name": name,
//     "email": email,
//     "mobile": mobile,
//     "password": password,
//   };
// }

class Manager {
  final String managerId;
  final String name;
  final String email;
  final String mobile;
  final String password;

  Manager(this.managerId, this.name, this.email, this.mobile, this.password);

  Manager.fromJson(Map<String, dynamic> data)
      : managerId = data['managerId'] as String,
        name = data['name'] as String,
        email = data['email'] as String,
        mobile = data['mobile'] as String,
        password = data['password'] as String;

  @override
  String toString() =>
      'Manager, managerId=$managerId, name=$name, email=$email, mobile=$mobile, password=$password';
}
