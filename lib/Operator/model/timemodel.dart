class TimeModel {
  final String? timeline;
  final String? taskId;
  final String? openDate;
  final String? closeDate;
  final String? actualCloseDate;
  final String? managerApprovalDate;
  final String? clientApprovalDate;
  final String? managerRejectionDate;
  final String? clientRejection;
  final String? assignationDate;
  final String? completionDate;
  final String? lastReassignation;

  TimeModel(
    this.timeline,
    this.taskId,
    this.openDate,
    this.closeDate,
    this.actualCloseDate,
    this.managerApprovalDate,
    this.clientApprovalDate,
    this.managerRejectionDate,
    this.clientRejection,
    this.assignationDate,
    this.completionDate,
    this.lastReassignation,
  );

  TimeModel.fromJson(Map<String, dynamic> data)
      : timeline = data['timeline'] as String?,
        taskId = data['taskId'] as String?,
        openDate = data['openDate'] as String?,
        closeDate = data['closeDate'] as String?,
        actualCloseDate = data['actualCloseDate'] as String?,
        managerApprovalDate = data['managerApprovalDate'] as String?,
        clientApprovalDate = data['clientApprovalDate'] as String?,
        managerRejectionDate = data['managerRejectionDate'] as String?,
        clientRejection = data['clientRejection'] as String?,
        assignationDate = data['assignationDate'] as String?,
        completionDate = data['completionDate'] as String?,
        lastReassignation = data['lastReassignation'] as String?;

  @override
  String toString() =>
      'timeline=$timeline, taskId=$taskId, openDate=$openDate, closeDate=$closeDate'
      'actualCloseDate=$actualCloseDate, managerApprovalDate=$managerApprovalDate, clientApprovalDate=$clientApprovalDate'
      'managerRejectionDate=$managerRejectionDate, clientRejection=$clientRejection, assignationDate=$assignationDate, completionDate=$completionDate, lastReassignation=$lastReassignation,';
}
