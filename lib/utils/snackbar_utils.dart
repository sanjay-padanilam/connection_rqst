import 'package:flutter/material.dart';

class SnackbarUrils {
  static showOntimeSnackbar(
      {required String message,
      required BuildContext context,
      Color backgroundColor = Colors.red}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
        backgroundColor: backgroundColor, // How long the SnackBar is visible
      ),
    );
  }
}
