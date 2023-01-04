class TaskModel {
  String taskId;
  String clientId;
  String? operatorId;
  String? managerId;
  String projectName;
  String taskName;
  String taskDescription;
  String openDate;
  String closeDate;
  String clientNote;
  String? managerNote;
  String? priority;
  String? assignationStatus;
  String? taskStatus;
  String? clientApproval;
  String? managerApproval;
  String? taskCategory;

  TaskModel(
    this.taskId,
    this.clientId,
    this.operatorId,
    this.managerId,
    this.projectName,
    this.taskName,
    this.taskDescription,
    this.openDate,
    this.closeDate,
    this.clientNote,
    this.managerNote,
    this.priority,
    this.assignationStatus,
    this.taskStatus,
    this.clientApproval,
    this.managerApproval,
    this.taskCategory,
  );

  TaskModel.fromJson(Map<String, dynamic> result)
      : taskId = result["taskID"] as String,
        clientId = result["clientId"] as String,
        operatorId = result["operatorId"] as String?,
        managerId = result["managerId"] as String?,
        projectName = result["ProjectName"] as String,
        taskName = result["taskName"] as String,
        taskDescription = result["taskDescription"] as String,
        openDate = result["openDate"] as String,
        closeDate = result["closeDate"] as String,
        clientNote = result["clientNote"] as String,
        managerNote = result["managerNote"] as String?,
        priority = result["priority"] as String?,
        assignationStatus = result["AssignationStatus"] as String?,
        taskStatus = result["taskStatus"] as String?,
        clientApproval = result["clientApproval"] as String?,
        managerApproval = result["managerApproval"] as String?,
        taskCategory = result["taskCategory"] as String?;

  @override
  String toString() =>
      'TaskModel, taskId=$taskId, clientId=$clientId, operatorId=$operatorId, managerId=$managerId, ProjectName=$projectName, taskName=$taskName, taskDescription=$taskDescription, openDate=$openDate, closeDate=$closeDate, clientNote=$clientNote, managerNote=$managerNote, priority=$priority, AssignationStatus=$assignationStatus, taskStatus=$taskStatus, clientApproval=$clientApproval, managerApproval=$managerApproval, taskCategory=$taskCategory';
}
