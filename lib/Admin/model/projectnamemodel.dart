class ProjectName {
  final String projectId;
  final String? projectName;
  final String active;


  ProjectName(this.projectId, this.projectName, this.active,);

  ProjectName.fromJson(Map<String, dynamic> data)
      : projectId = data['projectId'] as String,
        projectName = data['projectName'] as String?,
        active = data['active'] as String;

  @override
  String toString() =>
      'ProjectName, projectId=$projectId, projectName=$projectName, active=$active';
}