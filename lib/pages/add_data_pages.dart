import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


import '../service/service_api.dart';
import '../widget/text_field_widget.dart';

class AddDataPage extends StatefulWidget {
  const AddDataPage({super.key});

  @override
  State<AddDataPage> createState() => _AddDataPageState();
}

class _AddDataPageState extends State<AddDataPage> {
  DateTime? _startTime;
  DateTime? _endTime;
  String startTime = "";
  String endTime = "";





  _dateString() {
    if (_startTime == null) {
      return "Please chosse a start date";
    } else {
      return "${_startTime!.year}-${_startTime!.month}-${_startTime!.day} ";
    }
  }

  _endDateString() {
    if (_endTime == null) {
      return "Please chosse a end date";
    } else {
      return "${_endTime!.year}-${_endTime!.month}-${_endTime!.day} ";
    }
  }

  ServiceApi serviceApi = ServiceApi();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  TextEditingController _projectName = TextEditingController();
  TextEditingController project_update = TextEditingController();
  TextEditingController assigned_engineer = TextEditingController();
  TextEditingController assigned_technician = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Project"),
        backgroundColor: Colors.greenAccent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              CustomField(
                controller: _projectName,
                hintText: 'Project Name',
              ),
              SizedBox(
                height: 10,
              ),
              CustomField(
                controller: project_update,
                hintText: 'project_update',
              ),
              SizedBox(
                height: 10,
              ),
              CustomField(
                controller: assigned_engineer,
                hintText: 'assigned_engineer',
              ),
              SizedBox(
                height: 10,
              ),
              CustomField(
                controller: assigned_technician,
                hintText: 'assigned_technician',
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                  onPressed: () async {
                    final result = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2010),
                        lastDate: DateTime(2050));
                    String formattedDate =
                    DateFormat('yyyy-MM-dd').format(result!);
                    if (result != null) {
                      setState(() {
                        _startTime = result;
                        print(formattedDate);
                        startTime = formattedDate;
                      });
                    }
                  },
                  icon: Icon(Icons.calendar_month),
                  label: Text(_dateString())),
              SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                  onPressed: () async {
                    final result = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2010),
                        lastDate: DateTime(2050));
                    String formattedDate =
                    DateFormat('yyyy-MM-dd').format(result!);
                    if (result != null) {
                      setState(() {
                        _endTime = result;
                        endTime = formattedDate;
                      });
                    }
                  },
                  icon: Icon(Icons.calendar_month),
                  label: Text(_endDateString())),
              SizedBox(height: 20,),
              OutlinedButton(
                  onPressed: () {
// serviceApi.sendData();

                    if (startTime.isNotEmpty &&
                        endTime.isNotEmpty &&
                        _projectName.text.isNotEmpty &&
                        project_update.text.isNotEmpty &&
                        assigned_engineer.text.isNotEmpty &&
                        assigned_technician.text.isNotEmpty) {
                      serviceApi.addProjectElements(
                          startTime,
                          endTime,
                          _projectName.text,
                          project_update.text,
                          assigned_engineer.text,
                          assigned_technician.text);

                      _projectName.clear();
                      project_update.clear();
                      assigned_engineer.clear();
                      assigned_technician.clear();
                      _startTime = null;
                      _endTime = null;
                      setState(() {});
                    } else {
                      print("please enter all field");
                    }
                  },
                  child: Text("Submit")),


            ],
          ),
        ),
      ),
    );
  }
}
