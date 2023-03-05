import 'package:flutter/material.dart';
import 'package:task_manager_rest_api/screens/task/add_new_task.dart';
import '../../api/api_client.dart';
import '../../widgets/task_list.dart';
import '../../widgets/task_summary.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  List taskItem = [];
  bool isLoading = true;

  @override
  void initState() {
    CallData();
    super.initState();
  }

  CallData() async {
    var data = await ListTaskRequest('New');
    setState(() {
      taskItem = data;
      isLoading = false;
    });
  }

  deleteDialog(id) async {
    showDialog(
        context: context,
        builder: (BuildContext context) => Container(
              child: AlertDialog(
                title: const Text(
                  'Delete!',
                  style: TextStyle(color: Colors.red),
                ),
                content: const Text('Once delete, you can\'t get it back!'),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'No',
                        style: TextStyle(color: Colors.white),
                      )),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () async {
                        Navigator.pop(context);
                        setState(() {
                          isLoading = true;
                        });
                        await CallData();
                        await DeleteTaskRequest(id);
                      },
                      child: const Text(
                        'Yes',
                        style: TextStyle(color: Colors.white),
                      )),
                ],
              ),
            ));
  }

  String status = 'New';

  changeStatus(id) async {
    showModalBottomSheet(
        context: context,
        builder: ((context) {
          return StatefulBuilder(builder: (BuildContext context, setState) {
            return Container(
              height: 300,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Change Status',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  RadioListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('New'),
                      value: 'New',
                      groupValue: status,
                      onChanged: (value) {
                        setState(
                          () {
                            status = value.toString();
                          },
                        );
                      }),
                  RadioListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Progress'),
                      value: 'Progress',
                      groupValue: status,
                      onChanged: (value) {
                        setState(
                          () {
                            status = value.toString();
                          },
                        );
                      }),
                  RadioListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Cancelled'),
                      value: 'Cancelled',
                      groupValue: status,
                      onChanged: (value) {
                        setState(
                          () {
                            status = value.toString();
                          },
                        );
                      }),
                  RadioListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Completed'),
                      value: 'Completed',
                      groupValue: status,
                      onChanged: (value) {
                        setState(
                          () {
                            status = value.toString();
                          },
                        );
                      }),
                  const SizedBox(height: 10),
                  ElevatedButton(
                      onPressed: () async {
                        Navigator.pop(context);
                        setState(() {
                          isLoading = true;
                        });
                        await changeTaskStatueUpdateRequest(id, status);
                        await CallData();
                        setState(() {
                          status = 'New';
                        });
                      },
                      child: const Text('Change'))
                ],
              ),
            );
          });
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          label: const Text(
            'Add New',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddNewTaskScreen()));
          },
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: () async {
                  await CallData();
                },
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          task_summary(00,'New Task'),
                          task_summary(00, 'Progress'),
                          task_summary(00, 'Cancelled'),
                          task_summary(00, 'Completed'),
                        ],
                      ),
                      Expanded(
                          child: taskList(taskItem, deleteDialog, changeStatus))
                    ],
                  ),
                ),
              ));
  }
}
