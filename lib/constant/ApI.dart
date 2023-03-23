import 'package:flutter/material.dart';

// String ip = "http://142.93.222.48";
String ip = "https://task-manager-7gc9.onrender.com";
final managerlogout = "$ip/manager/logout";
final operatorlogout = '$ip/operator/logout';
final clientlogout = '$ip/client/logout';
final adminlogout = '$ip/admin/logout';

final managerlogin = "$ip/manager/login";
final operatorlogin = '$ip/operator/login';
final clientlogin = '$ip/client/login';
final adminlogin = '$ip/admin/login';

// MANAGER
final managergetassignedtask = "$ip/manager/assignedTask";
final manageraddOperator = '$ip/manager/addOperator';
final manageraddDepartment = '$ip/manager/addDepartment';
final managerAssigntask = '$ip/manager/assignTask/';
final managerProfile = '$ip/manager/profile';
final managerLogout = '$ip/manager/logout';

//ADMIN
final getmanagerlist = "$ip/admin/getManagers";
final getoperatorlist = "$ip/admin/getOperators";
final getclientlist = "$ip/admin/getClients";
final getdeactivatedmanagerlist = "$ip/admin/getDeactivatedManagers";
final getdeactivatedoperatorlist = "$ip/admin/getDeactivatedOperators";
final getdeactivatedclientlist = "$ip/admin/getDeactivatedClients";

//Client
final clientprofile = '$ip/client/profile';
final getcreatedtask = '$ip/client/trackYourTask';
final createtask = '$ip/client/createTask';
final gettasktimeline = '$ip/client/';
final approvetask = '$ip/client/';
final rejecttask = '$ip/client/';
final addlinks = '$ip/client/attachFiles';
final getlinks = '$ip/client/getAttachments';

//Operator
final operatortaskByOperatorId = '$ip/operator/taskByOperatorId';
final operatortasktimelinebyTaskId = "$ip/operator/getTimeline/";
