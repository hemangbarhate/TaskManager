class ClientModel {
  final String clientId;
  final String name;
  final String email;
  final String mobile;
  final String password;
  final String organization;

  ClientModel(this.clientId, this.name, this.email, this.mobile, this.password, this.organization,);

  ClientModel.fromJson(Map<String, dynamic> data)
      : clientId = data['clientId'] as String,
        name = data['name'] as String,
        email = data['email'] as String,
        mobile = data['mobile'] as String,
        organization = data['organization'] as String,
        password = data['password'] as String;


  @override
  String toString() =>
      'clientId=$clientId, name=$name, email=$email, mobile=$mobile, password=$password, organization=$organization';
}