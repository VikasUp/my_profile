import 'package:flutter/material.dart';
import 'package:my_profile/edit_page/edit_screen.dart';

class HomePage extends StatelessWidget {
  final String name = "Vikas Upadhyay";
  final String email = "vikasupadhyay221@gmail.com";
  final List<String> skills = ["FronEnd", "Api Inegrattion", "UI/UX Design"];
  final String workExperience = "1.3 years in Mobile App Development";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfilePage()),
                );
              }),
        ],
      ),
      body: Center(
        child: Card(
          elevation: 4,
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/avatar.png'),
                ),
                const SizedBox(height: 20),
                Text("Name: $name"),
                Text("Email: $email"),
                SizedBox(height: 20),
                const Text("Skills:"),
                Column(
                  children: skills.map((skill) => Text(skill)).toList(),
                ),
                SizedBox(height: 20),
                Text("Work Experience: $workExperience"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
