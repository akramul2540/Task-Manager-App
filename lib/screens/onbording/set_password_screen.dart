import 'package:flutter/material.dart';
import 'package:task_manager_rest_api/screens/onbording/login_screen.dart';

import '../../api/api_client.dart';
import '../../utility/utilites.dart';
import '../../widgets/background_images.dart';
import '../../widgets/reusable_elevated_button_style.dart';
import '../../widgets/textStyle.dart';
import '../../widgets/text_form_field_decoration.dart';
import '../../widgets/toast_message.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  Map<String, String> FormValue = {
    "email": "",
    "OTP": "",
    "password": "",
    "Cpassword": "",
  };
  bool isLoading = false;

  @override
  void initState() {
    callStoredData();
    super.initState();
  }

  callStoredData() async {
    String? OTP = await ReadUserData('OTPVerification');
    String? Email = await ReadUserData('EmailVerification');
    InputOnChange('OTP', OTP);
    InputOnChange('email', Email);
  }

  InputOnChange(MapKey, Textvalue) {
    setState(() {
      FormValue.update(MapKey, (value) => Textvalue);
    });
  }

  void FormOnSubmit() async {
    if (FormValue['password']!.isEmpty) {
      ErrorToast('Password Required!');
    } else if (FormValue['password'] != FormValue['Cpassword']) {
      ErrorToast('Confirm Password Sould be same!');
    } else {
      setState(() {
        isLoading = true;
      });
      bool res = await SetPasswordRequest(FormValue);
      if (res == true) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false);
      } else {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

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
                      const Text('Set Password', style: PageTitleText),
                      const SizedBox(height: 10),
                      const Text(
                          'Minimum length password 8 character with letter and number combination',
                          style: PageSubTitleText),
                      const SizedBox(height: 10),
                      TextFormField(
                        onChanged: (TextValue) {
                          InputOnChange('password', TextValue);
                        },
                        decoration: TextFormFieldInputDecoration(
                            'Password', 'Password'),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        onChanged: (TextValue) {
                          InputOnChange('Cpassword', TextValue);
                        },
                        obscureText: true,
                        decoration: TextFormFieldInputDecoration(
                            'Confirm Password', 'Confirm Password'),
                      ),
                      const SizedBox(height: 10),
                      ReusableElevatedButton(
                        onTap: () {
                          FormOnSubmit();
                        },
                        text: 'Confirm',
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Have account?'),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()));
                            },
                            child: const Text('Sign in'),
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
