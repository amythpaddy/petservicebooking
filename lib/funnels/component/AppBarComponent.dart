import 'package:flutter/material.dart';
import 'package:the_pet_nest/konstants/colors.dart';

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
      backgroundColor: kAppBackgroundAltGray,
      toolbarHeight: 200,
    );
  }
}
