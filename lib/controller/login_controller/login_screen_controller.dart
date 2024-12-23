import 'dart:developer';

import 'package:connection_rqst/controller/login_controller/login_screen_state.dart';
import 'package:connection_rqst/utils/snackbar_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginScreenStateProvider =
    StateNotifierProvider<LoginScreenStateNotifier, LoginScreenState>(
        (ref) => LoginScreenStateNotifier());

class LoginScreenStateNotifier extends StateNotifier<LoginScreenState> {
  LoginScreenStateNotifier() : super(LoginScreenState());

  Future<bool> onLogin({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = state.copyWith(isLoading: true);
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      log('Login successful for user: ${credential.user?.email ?? "Unknown"}');

      SnackbarUrils.showOntimeSnackbar(
          context: context,
          message: "Login successfully.",
          backgroundColor: Colors.green);

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        SnackbarUrils.showOntimeSnackbar(
            context: context, message: "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        SnackbarUrils.showOntimeSnackbar(
            context: context,
            message: "Wrong password provided for that user.");
      } else if (e.code == 'invalid-email') {
        SnackbarUrils.showOntimeSnackbar(
            context: context, message: "The email address is not valid.");
      } else {
        log('Unhandled FirebaseAuthException: ${e.code}', error: e);
        SnackbarUrils.showOntimeSnackbar(
            context: context, message: "Authentication failed.");
      }
      return false;
    } catch (e) {
      log('Login failed with error: $e', error: e);
      SnackbarUrils.showOntimeSnackbar(context: context, message: e.toString());
      return false;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
