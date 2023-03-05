import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager_rest_api/screens/onbording/login_screen.dart';
import '../../utility/utilites.dart';
import '../../widgets/background_images.dart';
import '../task/bottom_nav.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      SetupToken();
    });
    super.initState();
  }

  void SetupToken() async {
    String? token = await ReadUserData('token');
    if (token!=null) {
      Future.delayed(const Duration(seconds: 2)).then((value) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const BottomNavigationScreen()),
            (route) => false);
      });
    } else {
      Future.delayed(const Duration(seconds: 2)).then((value) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
          child: Center(child: SvgPicture.asset('assets/images/logo.svg'))),
    );
  }
}
