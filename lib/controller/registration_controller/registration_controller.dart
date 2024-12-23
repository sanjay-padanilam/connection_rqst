import 'package:connection_rqst/controller/registration_controller/registration_state.dart';
import 'package:connection_rqst/utils/snackbar_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final registrationScreenStateProvider = StateNotifierProvider<
    RegistrationScreenStateNotifier,
    RegistrationScreenState>((ref) => RegistrationScreenStateNotifier());

class RegistrationScreenStateNotifier
    extends StateNotifier<RegistrationScreenState> {
  RegistrationScreenStateNotifier() : super(RegistrationScreenState());

  Future<void> onRegistration({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = state.copyWith(isLoading: true);
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user?.uid != null) {
        // FirebaseFirestore.instance
        //     .collection("user")
        //     .doc(credential.user!.uid.toString())
        //     .set({
        //   "id": "${credential.user!.uid.toString()}",
        //   'email': '${credential.user!.email.toString()}'
        // });

        SnackbarUrils.showOntimeSnackbar(
          message: "Registration Successfully",
          context: context,
          backgroundColor: Colors.green,
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        SnackbarUrils.showOntimeSnackbar(
          message: 'The password provided is too weak.',
          context: context,
        );
      } else if (e.code == 'email-already-in-use') {
        SnackbarUrils.showOntimeSnackbar(
          message: 'The account already exists for that email.',
          context: context,
        );
      } else {
        SnackbarUrils.showOntimeSnackbar(
          message: 'Registration failed: ${e.code}',
          context: context,
        );
      }
    } catch (e) {
      SnackbarUrils.showOntimeSnackbar(
        message: e.toString(),
        context: context,
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
