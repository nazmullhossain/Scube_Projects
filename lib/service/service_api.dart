import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../model/task_model.dart';

class ServiceApi {
  void addProjectElements(
      String start_date,
      String end_date,
      String project_name,
      String project_update,
      String assigned_engineer,
      String assigned_technician) async {
    var url = Uri.parse(
        'https://scubetech.xyz/projects/dashboard/add-project-elements/');
    var response = await http.post(url, body: {
      'start_date': start_date,
      'end_date': end_date,
      'project_name': project_name,
      'project_update': project_update,
      'assigned_engineer': assigned_engineer,
      'assigned_technician': assigned_technician,
    });

    print(response.body);
    if (response.statusCode == 201) {
      print('Project elements added successfully');
      Fluttertoast.showToast(
          msg: "Project elements added successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );

    } else {
      print(
          'Failed to add project elements. Status code: ${response.statusCode}');
      Fluttertoast.showToast(
          msg: "Project elements added Unsuccessfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }





   updateProjectElements(int id,
    Map<String,dynamic>data,
      ) async {
    var url = Uri.parse('https://scubetech.xyz/projects/dashboard/update-project-elements/$id/');


    try {
      var response = await http.put(
        url,
        body: data,
      );

      if (response.statusCode == 200) {
        print('Project elements updated successfully.');
        Fluttertoast.showToast(
            msg: "Project elements updated successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      } else {
        print('Failed to update project elements. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
