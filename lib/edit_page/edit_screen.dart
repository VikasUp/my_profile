import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_profile/views/login_view/login_view.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final ImagePicker _imagePicker = ImagePicker();
  String editedName = "Vikas Upadhyay";
  String editedEmail = "vikasupadhyay221@gmail.com";
  String editedSkills = "Frontend in Flutter";
  String editedWorkExperience = "1.3 years";
  bool changesMade = false;
  XFile? selectedImage;

  Future<void> pickImage() async {
    final pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        selectedImage = pickedImage;
        changesMade = true;
      });
    }
  }

  Future<void> showLeaveWithoutSavingDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Leave without saving?"),
          content: Text(
              "You have unsaved changes. Are you sure you want to leave this page?"),
          actions: <Widget>[
            TextButton(
              child: Text("Yes"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showSavedSuccessfullyDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Saved Successfully"),
          content: Text("Your changes have been saved."),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void saveChanges() {
    setState(() {
      changesMade = false;

      showSavedSuccessfullyDialog(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginView()),
              );
            },
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          if (changesMade) {
            await showLeaveWithoutSavingDialog(context);
            return false;
          }
          return true;
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              InkWell(
                onTap: pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: selectedImage != null
                      ? FileImage(File(selectedImage!.path))
                          as ImageProvider<Object>
                      : AssetImage(
                          'assets/default_avatar.png',
                        ) as ImageProvider<Object>,
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text("Name: "),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          editedName = value;
                          changesMade = true;
                        });
                      },
                      controller: TextEditingController(text: editedName),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text("Email: "),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          editedEmail = value;
                          changesMade = true;
                        });
                      },
                      controller: TextEditingController(text: editedEmail),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text("Skills: "),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          editedSkills = value;
                          changesMade = true;
                        });
                      },
                      controller: TextEditingController(text: editedSkills),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text("Work Experience: "),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          editedWorkExperience = value;
                          changesMade = true;
                        });
                      },
                      controller:
                          TextEditingController(text: editedWorkExperience),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          saveChanges();
        },
        child: Icon(Icons.accessible_forward_sharp),
        backgroundColor: Colors.black,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
