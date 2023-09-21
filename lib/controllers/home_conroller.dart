import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_profile/authentication/authentication.dart';
import 'package:my_profile/bloc/authenticattion_bloc.dart';
import 'package:my_profile/bloc/authenticattion_state.dart';
import 'package:my_profile/views/home_view/home_view.dart';
import 'package:my_profile/views/welcom_view/welcome_view.dart';

class ScreenController extends StatelessWidget {
  const ScreenController({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        return BlocBuilder<AppBloc, AppState>(
          builder: (context, state) {
            if (state is AppStateLoggedIn) {
              return HomeView();
            }
            if (state is AppStateLoggedOut) {
              return WelcomeView();
            } else {
              return Container();
            }
          },
        );
      },
    );
  }
}
