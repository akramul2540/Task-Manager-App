import 'package:flutter/material.dart';
import '../../api/api_client.dart';
import '../../widgets/task_list.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  List TaskItem = [];
  bool isLoading = true;

  @override
  void initState() {
    CallData();
    super.initState();
  }

  CallData() async {
    var data = await ListTaskRequest('Progress');
    TaskItem = data;
    setState(() {
      isLoading = false;
    });
  }

  deleteDialog(id) async {
    showDialog(
        context: context,
        builder: (BuildContext context) => Container(
              child: AlertDialog(
                title: const Text('Delete!'),
                content: const Text('Once you delete you can\'t get it back!'),
                actions: [
                  ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'No',
                        style: TextStyle(color: Colors.white),
                      )),
                  ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        await CallData();
                        await DeleteTaskRequest(id);
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Yes',
                        style: TextStyle(color: Colors.white),
                      )),
                ],
              ),
            ));
  }

  String status = 'Progress';

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
                          status = 'Progress';
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
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: () async {
                  CallData();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: taskList(TaskItem, deleteDialog, changeStatus),
                )));
  }
}
