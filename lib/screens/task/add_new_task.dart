import 'package:flutter/material.dart';
import 'package:task_manager_rest_api/screens/task/bottom_nav.dart';
import 'package:task_manager_rest_api/widgets/background_images.dart';
import '../../api/api_client.dart';
import '../../widgets/reusable_elevated_button_style.dart';
import '../../widgets/textStyle.dart';
import '../../widgets/text_form_field_decoration.dart';
import '../../widgets/toast_message.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  Map<String, String> FormValue = {
    "title": "",
    "description": "",
    'status': 'New'
  };
  bool isLoading = false;

  InputOnChange(MapKey, Textvalue) {
    setState(() {
      FormValue.update(MapKey, (value) => Textvalue);
    });
  }

  void FormOnSubmit() async {
    if (FormValue['title']!.isEmpty) {
      ErrorToast('Subject Required!');
    } else if (FormValue['description']!.isEmpty) {
      ErrorToast('Description Required!');
    } else {
      setState(() {
        isLoading = true;
      });
      bool res = await AddNewTaskRequest(FormValue);
      if (res == true) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => const BottomNavigationScreen()),
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
        appBar: AppBar(),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Add New Task', style: PageTitleText),
                        const SizedBox(height: 10),
                        TextFormField(
                          onChanged: (TextValue) {
                            InputOnChange('title', TextValue);
                          },
                          decoration: TextFormFieldInputDecoration(
                              'Subject', 'Subject'),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          onChanged: (TextValue) {
                            InputOnChange('description', TextValue);
                          },
                          maxLines: 7,
                          decoration: TextFormFieldInputDecoration(
                              'Description', 'Description'),
                        ),
                        const SizedBox(height: 10),
                        ReusableElevatedButton(
                          onTap: () {
                            FormOnSubmit();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ));
  }
}
