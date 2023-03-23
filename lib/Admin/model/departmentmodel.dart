class Department {
  final String departmentId;
  final String? departmentName;


  Department(this.departmentId, this.departmentName,);

  Department.fromJson(Map<String, dynamic> data)
      : departmentId = data['departmentId'] as String,
        departmentName = data['departmentName'] as String?;

  @override
  String toString() =>
      'Department, departmentId=$departmentId, departmentName=$departmentName';
}