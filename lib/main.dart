import 'package:flutter/material.dart';
import 'package:task_manager_rest_api/screens/onbording/splash_screen.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
    );
  }
}


