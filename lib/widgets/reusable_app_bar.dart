import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:task_manager_rest_api/screens/task/profile_update_screen.dart';
import '../screens/onbording/login_screen.dart';
import '../utility/utilites.dart';

AppBar ReusableAppBar(context,ProfileData, {bool isTappable = true}) {
  return AppBar(
    title: ListTile(
      onTap: () {
        if (isTappable == false) {
          return;
        }
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ProfileUpdateScreen()));
      },
      leading: CircleAvatar(
        child: const Icon(IconlyBold.profile)
      ),
      title: Text('${ProfileData['firstName']}${ProfileData['lastName']}',
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
      subtitle:
          Text(ProfileData['email'], style: const TextStyle(fontSize: 14, color: Colors.white)),
    ),
    actions: [
      IconButton(
          onPressed: () async {
             await RemoveToken();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false);
          },
          icon: const Icon(IconlyLight.logout)),
    ],
    titleSpacing: 0,
  );
}
