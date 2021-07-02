import 'package:flutter/material.dart';

void showSnackbar(
    {required BuildContext context,
    String message = 'Something went wrong. Try again later.',
    int duration = 2}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    duration: Duration(seconds: duration),
  ));
}
