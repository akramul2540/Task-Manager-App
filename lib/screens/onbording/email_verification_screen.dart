import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:task_manager_rest_api/screens/onbording/pin_varification_screen.dart';
import '../../api/api_client.dart';
import '../../widgets/background_images.dart';
import '../../widgets/reusable_elevated_button_style.dart';
import '../../widgets/textStyle.dart';
import '../../widgets/text_form_field_decoration.dart';
import '../../widgets/toast_message.dart';
import 'login_screen.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      EmailVerificationScreenState();
}

class EmailVerificationScreenState extends State<EmailVerificationScreen> {

  Map<String, String> FormValue = {"email": ""};
  bool isLoading = false;

  InputOnChange(MapKey, Textvalue) {
    setState(() {
      FormValue.update(MapKey, (value) => Textvalue);
    });
  }

  void FormOnSubmit() async {
    if (FormValue['email']!.isEmpty) {
      ErrorToast('Email Required!');
    } else {
      setState(() {
        isLoading = true;
      });
      bool res = await VerifyEmailRequest(FormValue['email']);
      if (res == true) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => const PinVarificationScreen()),
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
                      const Text('Your Email Address', style: PageTitleText),
                      const SizedBox(height: 10),
                      const Text(
                          'A 6 digit varificaton pin will send to your email address',
                          style: PageSubTitleText),
                      const SizedBox(height: 10),
                      TextFormField(
                        onChanged: (TextValue) {
                          InputOnChange('email', TextValue);
                        },
                        decoration:
                            TextFormFieldInputDecoration('Email', 'Email', const Icon(IconlyBold.message)),
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
