class AttachmentModel {
  AttachmentModel(
    this.attachmentId,
    this.taskId,
    this.documentName,
    this.driveLink,
  );

  String attachmentId;
  String taskId;
  String documentName;
  String driveLink;

  AttachmentModel.fromJson(Map<String, dynamic> data)
  :
  attachmentId = data["attachmentId"] as String,
  taskId = data["taskId"] as String,
  documentName = data["documentName"] as String,
  driveLink = data["driveLink"] as String;

  @override
  String toString() =>
      'AttachmentModel, attachmentId=$attachmentId, taskId=$taskId, documentName=$documentName, driveLink=$driveLink';
}