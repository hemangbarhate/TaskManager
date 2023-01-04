import 'package:flutter/material.dart';

String ip = "164.92.83.169";
final managerlogout = "http://$ip/manager/logout";
final operatorlogout = 'http://$ip/operator/logout';
final clientlogout = 'http://$ip/client/logout';
final adminlogout = 'http://$ip/admin/logout';

final managerlogin = "http://$ip/manager/login";
final operatorlogin = 'http://$ip/operator/login';
final clientlogin = 'http://$ip/client/login';
final adminlogin = 'http://$ip/admin/login';

// MANAGER
final managergetassignedtask = "http://$ip/manager/assignedTask";
final manageraddOperator = 'http://$ip/manager/addOperator';
final manageraddDepartment = 'http://$ip/manager/addDepartment';
final managerAssigntask = 'http://$ip/manager/assignTask/';


//ADMIN
final getmanagerlist = "http://$ip/admin/getManagers";
final getoperatorlist = "http://$ip/admin/getOperators";
final getclientlist = "http://$ip/admin/getClients";

//Client
final clientprofile = 'http://$ip/client/profile';
final getcreatedtask = 'http://$ip/client/trackYourTask';
final createtask = 'http://$ip/client/createTask';
final gettasktimeline = 'http://$ip/client/';
final approvetask= 'http://$ip/client/';
final rejecttask = 'http://$ip/client/';
final addlinks= 'http://$ip/client/';
final getlinks = 'http://$ip/client/';
