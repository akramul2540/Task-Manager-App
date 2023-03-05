import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';


ListView taskList(taskItem, deleteDialog, changeStatus) {
  return ListView.builder(
      itemCount: taskItem.length,
      itemBuilder: (context, index) {
        Color statusColors = Colors.green;
        if (taskItem[index]['status']=='New'){
          statusColors = Colors.blue;
        } else if (taskItem[index]['status']=='Progress'){
          statusColors = Colors.purple;
        } else if (taskItem[index]['status']=='Cancelled') {
          statusColors = Colors.red;
        }

        return Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  taskItem![index]['title']?? '',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                 Text(
                  taskItem![index]['description']?? '',
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 8),
                Text(
                  'Date: ${taskItem![index]["createdDate"]?? ''}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                     Chip(
                      label: Text(
                       taskItem![index]['status'],
                        style:const TextStyle(color: Colors.white)
                      ),
                      backgroundColor: statusColors,
                    ),
                    Expanded(child: Container()),
                    IconButton(
                        onPressed: () {
                          changeStatus(taskItem[index]['_id']);
                        },
                        icon: const Icon(IconlyBold.editSquare,
                            color: Colors.greenAccent)),
                    IconButton(
                        onPressed: () {
                          deleteDialog(taskItem[index]['_id']);
                        },
                        icon: const Icon(
                          IconlyBold.delete,
                          color: Colors.redAccent,
                        )),
                  ],
                )
              ],
            ),
          ),
        );
      });
}


