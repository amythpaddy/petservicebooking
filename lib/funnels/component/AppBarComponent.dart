import 'package:flutter/material.dart';

class AppBarComponent extends AppBar {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Container(
        child: TextButton(
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        alignment: Alignment.topCenter,
        margin: EdgeInsets.only(top: 18),
      ),
      backgroundColor: Color(0xFF232C63),
      toolbarHeight: 200,
    );
  }
}
