import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_profile/bloc/authenticattion_bloc.dart';

import '../../bloc/authenticattion_event.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ElevatedButton(
        onPressed: () => context.read<AppBloc>().add(const AppEventLogOut()),
        child: Text('Sign out'),
      ),
    ));
  }
}
