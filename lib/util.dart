import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

bool isDarkMode(BuildContext context) =>
    MediaQuery.of(context).platformBrightness == Brightness.dark;

void showFirebaseErrorSnack(
  Object? error,
) {
  String message;
  if (error is FirebaseException) {
    message = error.message ?? "Something went wrong.";
  } else if (error is UnimplementedError) {
    message = "This feature is not implemented.";
  } else {
    message = "An unexpected error occurred.";
  }

  final snackBar = SnackBar(content: Text(message));
  scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
}
