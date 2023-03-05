import 'package:flutter/material.dart';
import 'package:task_manager_rest_api/screens/onbording/login_screen.dart';
import '../../api/api_client.dart';
import '../../widgets/background_images.dart';
import '../../widgets/reusable_elevated_button_style.dart';
import '../../widgets/textStyle.dart';
import '../../widgets/text_form_field_decoration.dart';
import '../../widgets/toast_message.dart';

class RegistationScreen extends StatefulWidget {
  const RegistationScreen({super.key});

  @override
  State<RegistationScreen> createState() => _RegistationScreenState();
}

class _RegistationScreenState extends State<RegistationScreen> {
  Map<String, String> FormValue = {
    "email": "",
    "firstName": "",
    "lastName": "",
    "mobile": "",
    "password": "",
    'photo': '',
    "Cpassword": "",
  };
  bool isLoading = false;

  InputOnChange(MapKey, Textvalue) {
    setState(() {
      FormValue.update(MapKey, (value) => Textvalue);
    });
  }

  void FormOnSubmit() async {
    if (FormValue['email']!.isEmpty) {
      ErrorToast('Email Required!');
    } else if (FormValue['firstName']!.isEmpty) {
      ErrorToast('firstName Required!');
    } else if (FormValue['lastName']!.isEmpty) {
      ErrorToast('lastName Required!');
    } else if (FormValue['mobile']!.isEmpty) {
      ErrorToast('mobile Required!');
    } else if (FormValue['password']!.isEmpty) {
      ErrorToast('Password Required!');
    } else if (FormValue['password']!=FormValue['Cpassword']) {
      ErrorToast('Confirm Password Sould be same!');
    } else {
      setState(() {
        isLoading = true;
      });
      bool res = await RegistaionRequest(FormValue);
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
                      const Text('Join with us', style: PageTitleText),
                      const SizedBox(height: 10),
                      TextFormField(
                        onChanged: (TextValue) {
                          InputOnChange('email', TextValue);
                        },
                        decoration:
                            TextFormFieldInputDecoration('Email', 'Email'),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        onChanged: (TextValue) {
                          InputOnChange('firstName', TextValue);
                        },
                        decoration: TextFormFieldInputDecoration(
                            'First Name', 'First Name'),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        onChanged: (TextValue) {
                          InputOnChange('lastName', TextValue);
                        },
                        decoration: TextFormFieldInputDecoration(
                            'Last Name', 'Last Name'),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: (TextValue) {
                          InputOnChange('mobile', TextValue);
                        },
                        decoration:
                            TextFormFieldInputDecoration('Mobile', 'Mobile'),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        onChanged: (TextValue) {
                          InputOnChange('password', TextValue);
                        },
                        obscureText: true,
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
