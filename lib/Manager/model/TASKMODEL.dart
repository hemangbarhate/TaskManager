
class TaskModel {
  final String? taskID;
  final String? clientId;
  final String? operatorId;
  final String? managerId;
  final String? ProjectName;
  final String? taskName;
  final String? taskDescription;
  final String? openDate;
  final String? closeDate;
  final String? clientNote;
  final String? managerNote;
  final String? priority;
  final String? AssignationStatus;
  final String? taskStatus;
  final String? clientApproval;
  final String? managerApproval;
  final String? taskCategory;



  TaskModel(this.taskID, this.clientId, this.operatorId, this.managerId, this.ProjectName,
      this.taskName, this.taskDescription, this.openDate, this.closeDate, this.clientNote,
      this.managerNote,this.priority, this.AssignationStatus, this.taskStatus,
      this.clientApproval, this.managerApproval, this.taskCategory,
      );

  TaskModel.fromJson(Map<String, dynamic> data)
      : taskID = data['taskID'] as String?,
        clientId = data['clientId'] as String?,
        operatorId = data['operatorId'] as String?,
        managerId = data['managerId'] as String?,
        ProjectName = data['ProjectName'] as String?,
        taskName = data['taskName'] as String?,
        taskDescription = data['taskDescription'] as String?,
        openDate = data['openDate'] as String?,
        closeDate = data['closeDate'] as String?,
        clientNote = data['clientNote'] as String?,
        managerNote = data['managerNote'] as String?,
        priority = data['priority'] as String?,
        AssignationStatus = data['AssignationStatus'] as String?,
        taskStatus = data['taskStatus'] as String?,
        clientApproval = data['clientApproval'] as String?,
        managerApproval = data['managerApproval'] as String?,
        taskCategory = data['taskCategory'] as String?;

  @override
  String toString() =>
      'taskID=$taskID, clientId=$clientId, operatorId=$operatorId, managerId=$managerId, ProjectName=$ProjectName'
  'taskName=$taskName, taskDescription=$taskDescription, openDate=$openDate, closeDate=$closeDate, clientNote=$clientNote'
          'managerNote=$managerNote, priority=$priority, AssignationStatus=$AssignationStatus, taskStatus=$taskStatus, clientApproval=$clientApproval, managerApproval=$managerApproval taskCategory=$taskCategory,';
}
