import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_rest_api/screens/onbording/set_password_screen.dart';
import '../../api/api_client.dart';
import '../../utility/utilites.dart';
import '../../widgets/background_images.dart';
import '../../widgets/reusable_elevated_button_style.dart';
import '../../widgets/textStyle.dart';
import '../../widgets/toast_message.dart';
import 'login_screen.dart';
import '';

class PinVarificationScreen extends StatefulWidget {
  const PinVarificationScreen({super.key});

  @override
  State<PinVarificationScreen> createState() => _PinVarificationScreenState();
}

class _PinVarificationScreenState extends State<PinVarificationScreen> {
  Map<String, String> FormValue = {"otp": ""};
  bool isLoading = false;

  InputOnChange(MapKey, Textvalue) {
    setState(() {
      FormValue.update(MapKey, (value) => Textvalue);
    });
  }

  void FormOnSubmit() async {
    if (FormValue['otp']!.isEmpty) {
      ErrorToast('OTP pin Required!');
    } else {
      setState(() {
        isLoading = true;
      });
      String? emailAddress = await ReadUserData('EmailVerification');
      bool res = await VerifyOTPlRequest(emailAddress, FormValue['otp']);
      if (res == true) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const SetPasswordScreen()),
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
                      const Text('Get started with', style: PageTitleText),
                      const SizedBox(height: 10),
                      const Text(
                          'A 6 digit varificaton pin will send to your email address',
                          style: PageSubTitleText),
                      const SizedBox(height: 10),
                      PinCodeTextField(
                        length: 6,
                        obscureText: false,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          inactiveFillColor: Colors.green,
                          inactiveColor: Colors.green,
                          errorBorderColor: Colors.red,
                          fieldHeight: 50,
                          fieldWidth: 40,
                          activeFillColor: Colors.white,
                        ),
                        onCompleted: (v) {},
                        onChanged: (value) {
                          InputOnChange('otp', value);
                        },
                        appContext: context,
                      ),
                      const SizedBox(height: 10),
                      ReusableElevatedButton(
                        onTap: () {
                          FormOnSubmit();
                        },
                        text: 'Verify',
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
