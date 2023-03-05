import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:task_manager_rest_api/screens/onbording/email_verification_screen.dart';
import 'package:task_manager_rest_api/screens/onbording/registation_screen.dart';
import 'package:task_manager_rest_api/widgets/background_images.dart';
import 'package:task_manager_rest_api/widgets/toast_message.dart';
import '../../api/api_client.dart';
import '../../widgets/reusable_elevated_button_style.dart';
import '../../widgets/textStyle.dart';
import '../../widgets/text_form_field_decoration.dart';
import '../task/bottom_nav.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  Map<String, String> FormValue = {"email": "", "password": ""};
  bool isLoading = false;

  InputOnChange(MapKey, Textvalue) {
    setState(() {
      FormValue.update(MapKey, (value) => Textvalue);
    });
  }

  void FormOnSubmit() async {
    if (FormValue['email']!.isEmpty) {
      ErrorToast('Email Required!');
    } else if (FormValue['password']!.isEmpty) {
      ErrorToast('Password Required!');
    } else {
      setState(() {
        isLoading = true;
      });
      bool res = await LoginRequest(FormValue);
      if (res == true) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const BottomNavigationScreen()),
            (route) => false);
      } else {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  var obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
          child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Get started with', style: PageTitleText),
                      const SizedBox(height: 10),
                      TextFormField(
                        onChanged: (TextValue) {
                          InputOnChange('email', TextValue);
                        },
                        decoration:
                            TextFormFieldInputDecoration('Email', 'Email', const Icon(IconlyBold.message)),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        onChanged: (TextValue) {
                          InputOnChange('password', TextValue);
                        },
                        obscureText: obscureText,
                        decoration: passwordTextFormFieldInputDecoration(
                            'Password', 'Password', const Icon(IconlyBold.lock), InkWell(
                              onTap: () {
                                 obscureText = !obscureText;
                                 setState(() {});
                              },
                              child: obscureText? const Icon(Icons.visibility_off): const Icon(Icons.visibility))),
                      ),
                      const SizedBox(height: 10),
                      ReusableElevatedButton(
                        onTap: () {
                          FormOnSubmit();
                        },
                      ),
                      const SizedBox(height: 30),
                      Center(
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const EmailVerificationScreen()));
                              },
                              child: const Text(
                                'Forgot password?',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ))),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Don\'t have account?'),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RegistationScreen()));
                            },
                            child: const Text('Sign up'),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
      )),
    );
  }
}
