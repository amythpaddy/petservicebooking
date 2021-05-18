import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:the_pet_nest/config/sizeConfig.dart';
import 'package:the_pet_nest/sidebar/component/welcome/loginModal.dart';
import 'package:the_pet_nest/sidebar/component/welcome/otpModal.dart';
import 'package:the_pet_nest/sidebar/component/welcome/registerModal.dart';
import 'package:the_pet_nest/welcome/welcome/intro.dart';

class WelcomeModal extends StatefulWidget {
  @override
  _WelcomeModalState createState() => _WelcomeModalState();
}

enum Screens { WELCOME_SCREEN, LOGIN_SCREEN, REGISTER_SCREEN, OTP_SCREEN }

class _WelcomeModalState extends State<WelcomeModal> {
  Screens currentScreen = Screens.WELCOME_SCREEN;
  Widget body;

  void switchScreen() {}

  @override
  Widget build(BuildContext context) {
    switch (currentScreen) {
      case Screens.WELCOME_SCREEN:
        body = Intro();
        break;
      case Screens.LOGIN_SCREEN:
        body = LoginModal();
        break;
      case Screens.REGISTER_SCREEN:
        body = RegisterModal();
        break;
      case Screens.OTP_SCREEN:
        body = OtpModal();
        break;
    }
    SizeConfig().init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(22),
                    topRight: Radius.circular(22))),
            child: body),
      ),
    );
  }
}
