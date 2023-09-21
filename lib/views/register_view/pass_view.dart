import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_profile/bloc/authenticattion_bloc.dart';
import 'package:my_profile/bloc/authenticattion_event.dart';
import 'package:my_profile/bloc/authenticattion_state.dart';
import 'package:my_profile/controllers/txt_controller.dart';
import 'package:my_profile/home_page.dart/home_screen.dart';

class PasswordView extends StatefulWidget {
  const PasswordView({super.key});

  @override
  State<PasswordView> createState() => _PasswordViewState();
}

class _PasswordViewState extends State<PasswordView> {
  bool visiblePassword = true;
  bool savePassword = false; // Added to track whether to save the password

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0),
      ),
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 50),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, bottom: 25),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Insert a password',
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Insert a password to create your account',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade500),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Icon(
                      Icons.password,
                      color: Colors.grey.shade500,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    SizedBox(
                      height: 50,
                      width: 250,
                      child: TextField(
                        controller: passwordController,
                        obscureText: visiblePassword,
                        autofocus: true,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    visiblePassword = !visiblePassword;
                                  });
                                },
                                icon: Icon(
                                  Icons.remove_red_eye,
                                  color: visiblePassword
                                      ? Colors.grey.shade500
                                      : Colors.amber,
                                )),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.amber)),
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Colors.grey.shade500),
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade500))),
                      ),
                    )
                  ],
                ),
              ),
            ),
            // Save Password Checkbox
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Row(
                children: [
                  Checkbox(
                    value: savePassword,
                    onChanged: (value) {
                      setState(() {
                        savePassword = value ?? false;
                      });
                    },
                  ),
                  Text("Save Password"),
                ],
              ),
            ),
            // Confirm Button
            BlocBuilder<AppBloc, AppState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Align(
                    alignment: Alignment.center,
                    child: state.isLoading
                        ? CircularProgressIndicator()
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: SizedBox(
                              width: 250,
                              height: 50,
                              child: MaterialButton(
                                onPressed: () {
                                  context.read<AppBloc>().add(AppEventRegister(
                                      email: emailController.text,
                                      password: passwordController.text));
                                  if (savePassword) {
                                    // Save password logic here
                                    // You can use a storage solution like shared preferences or secure storage
                                  }
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => HomePage(),
                                    ),
                                  );
                                },
                                color: const Color.fromARGB(255, 6, 6, 6),
                                child: Text(
                                  'Confirm',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
