class DepartmentModel {
  final String name;

  DepartmentModel(
    this.name,
  );

  DepartmentModel.fromJson(Map<String, dynamic> data)
      : name = data['name'] as String;

  @override
  String toString() => ' name=$name,';
}
