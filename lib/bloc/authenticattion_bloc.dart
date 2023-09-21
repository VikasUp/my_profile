import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_profile/authentication/authentication.dart';
import 'package:my_profile/authentication/authentication_error.dart';
import 'package:my_profile/bloc/authenticattion_event.dart';
import 'package:my_profile/bloc/authenticattion_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppStateLoggedOut(isLoading: false, successful: false)) {
    on<AppEventLogIn>((event, emit) async {
      emit(AppStateLoggedOut(isLoading: true, successful: false));
      try {
        await Auth().signInWithEmailAndPassword(
            email: event.email, password: event.password);
        emit(AppStateLoggedIn(isLoading: false, successful: true));
      } on FirebaseAuthException catch (e) {
        print(e);
        authErrorlogin = e.toString();
        emit(AppStateLoggedOut(isLoading: false, successful: false));
      }
    });

    on<AppEventLogOut>((event, emit) async {
      emit(AppStateLoggedOut(isLoading: true, successful: false));
      try {
        await Auth().signOut();
        emit(AppStateLoggedOut(isLoading: false, successful: true));
      } on FirebaseAuthException catch (e) {}
    });

    on<AppEventRegister>((event, emit) async {
      emit(AppStateLoggedOut(isLoading: true, successful: false));
      try {
        await Auth().createUserWithEmailAndPassword(
            email: event.email, password: event.password);
        emit(AppStateLoggedIn(isLoading: false, successful: true));
      } on FirebaseAuthException catch (e) {
        print(e);
        authErrorRegister = e.toString();
        emit(AppStateLoggedOut(isLoading: false, successful: false));
      }
    });

    on<AppEventResetPassword>((event, emit) async {
      emit(AppStateLoggedOut(isLoading: true, successful: false));
      try {
        await Auth().sendResetPasswordEmail(email: event.email);
        emit(AppStateLoggedIn(isLoading: false, successful: true));
      } on FirebaseAuthException catch (e) {
        print(e);
        authErrorlogin = e.toString();
        emit(AppStateLoggedOut(isLoading: false, successful: false));
      }
    });
  }
}
