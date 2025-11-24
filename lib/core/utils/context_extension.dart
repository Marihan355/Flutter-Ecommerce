import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {  //context is my identity and location inside the ui tree. like a passport / BuildContext tells the widgets's location inside the whole app, so when i say show snackbar, it knows where: which page
  void showSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(message)));
  }

  void navigateReplacement(Widget page) {
    Navigator.pushReplacement(
      this,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  void navigateTo(Widget page) {
    Navigator.push(
      this,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}
