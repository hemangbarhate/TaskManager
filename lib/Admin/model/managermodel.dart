
class Operator {
  final String managerId;
  final String name;
  final String email;
  final String mobile;
  final String password;

  Operator(this.managerId, this.name, this.email, this.mobile, this.password);

  Operator.fromJson(Map<String, dynamic> data)
      : managerId = data['managerId'] as String,
        name = data['name'] as String,
        email = data['email'] as String,
        mobile = data['mobile'] as String,
        password = data['password'] as String;

  @override
  String toString() =>
      'Manager, managerId=$managerId, name=$name, email=$email, mobile=$mobile, password=$password';
}
