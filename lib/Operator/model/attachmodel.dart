class AttachModel {
  final String? attachmentId;
  final String? taskId;
  final String? documentName;
  final String? driveLink;

  AttachModel(
      this.attachmentId,
      this.taskId,
      this.documentName,
      this.driveLink,
      );

  AttachModel.fromJson(Map<String, dynamic> data)
      : attachmentId = data['attachmentId'] as String?,
        taskId = data['taskId'] as String?,
        documentName = data['documentName'] as String?,
        driveLink = data['driveLink'] as String?;


  @override
  String toString() =>
      'attachmentId=$attachmentId, taskId=$taskId, documentName=$documentName, driveLink=$driveLink';
}
// {attachmentId: 04c2375e-248f-42b2-bec0-de17931cf0ca, taskId: 20cf1488-3420-4341-96e6-de90fd4faefa,
// documentName: Adhar Card, driveLink: https://www.google.com/},