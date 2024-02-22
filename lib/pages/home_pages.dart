import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scube_task/pages/add_data_pages.dart';

import '../service/service_api.dart';
import '../widget/text_field_widget.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  StreamController<List<dynamic>> _streamController =
      StreamController<List<dynamic>>();
  TextEditingController start_date = TextEditingController();
  TextEditingController end_date = TextEditingController();
  TextEditingController project_name = TextEditingController();
  TextEditingController project_update = TextEditingController();
  TextEditingController assigned_engineer = TextEditingController();
  TextEditingController assigned_technician = TextEditingController();
  ServiceApi serviceApi = ServiceApi();

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://scubetech.xyz/projects/dashboard/all-project-elements/'));

    if (response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(response.body);
        _streamController.add(data);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      fetchData();
    });
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: Center(
        child: StreamBuilder<List<dynamic>>(
          stream: _streamController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
         
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final item = snapshot.data![index];
                  return Container(
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      title: CircleAvatar(child: Text(item['id'].toString())),
                      trailing: InkWell(
                          onTap: () {
                            start_date.text = item["start_date"];
                            end_date.text = item["end_date"];
                            project_name.text = item["project_name"];
                            project_update.text = item["project_update"];
                            assigned_engineer.text = item["assigned_engineer"];
                            assigned_technician.text =
                                item["assigned_technician"];
                            // Navigator.push(context, MaterialPageRoute(builder: (_)=>NewEdit(id: item['id'], project_name: item["project_name"])));

                            editEm(item["id"]);
                          },
                          child: Icon(Icons.edit,color: Colors.white,size: 40,)),
                      subtitle: Column(
                        children: [
                          Text("Project Name: ${item['project_name']}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                          Text("Start-Date: ${item['start_date']}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),),
                          Text("End-Date:${item['end_date']}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),),
                          Text("Project Update: ${item['project_update']}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),),
                          Text("Assigned Engineer: ${item['assigned_engineer']}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),),
                          Text("assigned_technician: ${item['assigned_technician']}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),),
                        ],
                      ),
                      // Add more widgets to display data as needed
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            // By default, show a loading spinner
            return CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => AddDataPage()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future editEm(int id) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: SingleChildScrollView(
              child: Container(
                height: 600,
                child: Column(
                  children: [
                    Text(
                      "Update Todo",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    CustomField(
                      controller: start_date,
                      hintText: 'start_date',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomField(
                      controller: end_date,
                      hintText: 'end_date',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomField(
                      controller: project_name,
                      hintText: 'project_name',
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
                    OutlinedButton(
                        onPressed: () async {
                          Map<String, dynamic> data = {
                            "start_date": start_date.text,
                            "end_date": end_date.text,
                            "project_name": project_name.text,
                            "project_update": project_update.text,
                            "assigned_engineer": assigned_engineer.text,
                            "assigned_technician": assigned_technician.text,
                          };
                          await serviceApi.updateProjectElements(id, data);

                          Navigator.pop(context);
                        },
                        child: Text("Update"))
                  ],
                ),
              ),
            ),
          ));
}
