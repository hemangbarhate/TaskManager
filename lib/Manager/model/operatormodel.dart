
class OperatorData {
  final String operatorId;
  final String name;
  final String email;
  final String mobile;
  final String password;
  final String departmentId;

  OperatorData(this.operatorId, this.name, this.email, this.mobile, this.password, this.departmentId,);

  OperatorData.fromJson(Map<String, dynamic> data)
      : operatorId = data['operatorId'] as String,
        name = data['name'] as String,
        email = data['email'] as String,
        mobile = data['mobile'] as String,
        password = data['password'] as String,
        departmentId = data['departmentId'] as String;

  @override
  String toString() =>
      'Operator, operatorId=$operatorId, name=$name, email=$email, mobile=$mobile, password=$password, departmentId=$departmentId';
}