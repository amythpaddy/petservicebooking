import 'package:flutter/material.dart';

class LoggedInHeader extends StatelessWidget {
  const LoggedInHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 50),
        child: Image.asset('assets/the_pet_nest.png'));
  }
}
