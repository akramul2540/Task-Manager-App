import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:task_manager_rest_api/screens/task/progress_screen.dart';
import 'package:task_manager_rest_api/utility/utilites.dart';
import '../../widgets/reusable_app_bar.dart';
import 'cancelled_screen.dart';
import 'completed_task.dart';
import 'new_task_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int currentIndex = 0;

  final List Pages = const [
    NewTaskScreen(),
    ProgressTaskScreen(),
    CancelledTaskScreen(),
    CompletedTaskScreen(),
  ];


Map <String, String> ProfileData ={'email':'','firstName':'','lastName':'','photo':'',};

 readAppBarData() async {
  String? email = await ReadUserData('email');
  String? firstName = await ReadUserData('firstName');
  String? lastName = await ReadUserData('lastName');
  String? photo = await ReadUserData('photo');
  setState(() {
 ProfileData ={'email':'$email','firstName':'$firstName','lastName':'$lastName','photo':'$photo',};
  });
 }

 @override
 void initState() {
   readAppBarData();
   super.initState();
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ReusableAppBar(context, ProfileData, isTappable: true),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            elevation: 20,
            selectedItemColor: Colors.green,
            unselectedItemColor: Colors.grey,
            currentIndex: currentIndex,
            onTap: (index) {
              currentIndex = index;
              setState(() {});
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(currentIndex == 0
                      ? IconlyBold.document
                      : IconlyLight.document),
                  label: 'New Task'),
              BottomNavigationBarItem(
                  icon: Icon(
                      currentIndex == 1 
                      ? IconlyBold.paper 
                      : IconlyLight.paper),
                  label: 'Progress'),
              BottomNavigationBarItem(
                  icon: Icon(currentIndex == 2
                      ? IconlyBold.paperFail
                      : IconlyLight.paperFail),
                  label: 'Cancelled'),
              BottomNavigationBarItem(
                  icon: Icon(currentIndex == 3
                      ? IconlyBold.paperDownload
                      : IconlyLight.paperDownload),
                  label: 'Completed'),
            ]),
        body: Pages[currentIndex]);
  }
}
