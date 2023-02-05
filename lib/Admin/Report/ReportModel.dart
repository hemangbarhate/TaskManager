class ReportModel {
  ReportModel(
      this.taskName,
      this.openDate,
      this.assignationDate,
      this.operatorAcceptDate,
      this.actualCloseDate,
      this.closeDate,
      this.AssignationStatus,
      this.taskStatus,
      );

  String? taskName;
  String? openDate;
  String? assignationDate;
  String? operatorAcceptDate;
  String? actualCloseDate;
  String? closeDate;
  String? AssignationStatus;
  String? taskStatus;

  ReportModel.fromJson(Map<String, dynamic> result)
      :
        taskName = result["taskName"] as String?,
        openDate = result["openDate"] as String?,
        assignationDate = result["assignationDate"] as String?,
        operatorAcceptDate = result["operatorAcceptDate"] as String?,
        actualCloseDate = result["actualCloseDate"] as String?,
        closeDate = result["closeDate"] as String?,
        AssignationStatus = result["AssignationStatus"] as String?,
        taskStatus = result["taskStatus"] as String?;


  @override
  String toString() =>
      'ReportModel, taskName=$taskName, openDate=$openDate, assignationDate=$assignationDate, operatorAcceptDate=$operatorAcceptDate,actualCloseDate=$actualCloseDate,closeDate=$closeDate,AssignationStatus=$AssignationStatus,taskStatus=$taskStatus';
}