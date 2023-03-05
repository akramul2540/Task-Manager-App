import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager_rest_api/widgets/background_images.dart';
import 'package:task_manager_rest_api/widgets/reusable_app_bar.dart';
import '../../utility/utilites.dart';
import '../../widgets/reusable_elevated_button_style.dart';
import '../../widgets/textStyle.dart';
import '../../widgets/text_form_field_decoration.dart';

class ProfileUpdateScreen extends StatefulWidget {
  const ProfileUpdateScreen({super.key});

  @override
  State<ProfileUpdateScreen> createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  XFile? photoFile;

  profileUpadteData() async {
    String? email = await ReadUserData('email');
    String? firstName = await ReadUserData('firstName');
    String? lastName = await ReadUserData('lastName');
    String? mobile = await ReadUserData('mobile');
    emailEditingController.text = email ?? '';
    firstNameEditingController.text = firstName ?? '';
    lastNameEditingController.text = lastName ?? '';
    mobileEditingController.text = mobile ?? '';
  }

  @override
  void initState() {
    profileUpadteData();
    super.initState();
  }

  TextEditingController emailEditingController = TextEditingController();
  TextEditingController firstNameEditingController = TextEditingController();
  TextEditingController lastNameEditingController = TextEditingController();
  TextEditingController mobileEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Update Profile', style: PageTitleText),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () async {
                      final imagePicker = ImagePicker();
                      final result = await imagePicker.pickImage(
                          source: ImageSource.gallery);
                      if (result != null) {
                        photoFile = result;
                      }
                      setState(() {});
                    },
                    child: SizedBox(
                      height: 45,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: double.infinity,
                              width: 60,
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(6),
                                    bottomLeft: Radius.circular(6)),
                              ),
                              child: const Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Photo',
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8, right: 5),
                              child: Flexible(
                                  child: Text(
                                      photoFile?.name ?? 'Select a photo')),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    readOnly: true,
                    controller: emailEditingController,
                    decoration:
                        TextFormFieldInputDecoration('Email', 'Email'),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    readOnly: true,
                    controller: firstNameEditingController,
                    decoration: TextFormFieldInputDecoration(
                        'First Name', 'First Name'),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    readOnly: true,
                    controller: lastNameEditingController,
                    decoration: TextFormFieldInputDecoration(
                        'Last Name', 'Last Name'),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    readOnly: true,
                    controller: mobileEditingController,
                    keyboardType: TextInputType.number,
                    decoration:
                        TextFormFieldInputDecoration('Mobile', 'Mobile'),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    obscureText: true,
                    decoration:
                        TextFormFieldInputDecoration('Password', 'Password'),
                  ),
                  const SizedBox(height: 10),
                  ReusableElevatedButton(
                    onTap: () {},
                    text: 'Update',
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
