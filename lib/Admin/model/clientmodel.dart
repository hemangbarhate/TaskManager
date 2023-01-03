class Client {
  final String clientId;
  final String name;
  final String email;
  final String mobile;
  final String password;
  final String organization;

  Client(this.clientId, this.name, this.email, this.mobile, this.password, this.organization,);

  Client.fromJson(Map<String, dynamic> data)
      : clientId = data['clientId'] as String,
        name = data['name'] as String,
        email = data['email'] as String,
        mobile = data['mobile'] as String,
        password = data['password'] as String,
        organization = data['organization'] as String;

  @override
  String toString() =>
      'Client, clientId=$clientId, name=$name, email=$email, mobile=$mobile, password=$password, organization=$organization';
}