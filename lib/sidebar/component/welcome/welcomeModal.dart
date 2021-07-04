import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_pet_nest/config/sizeConfig.dart';
import 'package:the_pet_nest/konstants/values.dart';
import 'package:the_pet_nest/sidebar/component/welcome/loginModal.dart';
import 'package:the_pet_nest/sidebar/component/welcome/otpModal.dart';
import 'package:the_pet_nest/sidebar/component/welcome/registerModal.dart';
import 'package:the_pet_nest/welcome/models/loginDataModel.dart';
import 'package:the_pet_nest/welcome/models/registerDataModel.dart';
import 'package:the_pet_nest/welcome/welcome/intro.dart';

class WelcomeModal extends StatefulWidget {
  @override
  _WelcomeModalState createState() => _WelcomeModalState();
}

enum Screens {
  WELCOME_SCREEN,
  LOGIN_SCREEN,
  REGISTER_SCREEN,
  OTP_SCREEN,
  SELECT_PET_SCREEN,
  PET_INFO_PAGE,
  ADDED_PET_PAGE
}

class _WelcomeModalState extends State<WelcomeModal> {
  late SharedPreferences prefs;
  Screens currentScreen = Screens.WELCOME_SCREEN;
  late Widget body;
  String phoneNumber = '';
  final double normalHeight = 616;
  final double loginHeight = 483;
  final double otpHeight = 552;
  final double selectPetHeight = 445;
  final double petInfoHeight = 672;
  late LoginRequest? loginRequest;
  late RegisterRequest? registerRequest;

  double heightProp = 616;

  void switchScreen() {}

  void introScreenReponse(String response) {
    if (response == kPopupSelectLogin)
      setState(() {
        currentScreen = Screens.LOGIN_SCREEN;
        heightProp = loginHeight;
      });
    else if (response == kPopupSelectRegister)
      setState(() {
        currentScreen = Screens.REGISTER_SCREEN;
        heightProp = normalHeight;
      });
  }

  void loginScreenResponse(String response, LoginRequest request) {
    loginRequest = request;
    if (response == kPopupSelectOTP)
      setState(() {
        currentScreen = Screens.OTP_SCREEN;
        heightProp = otpHeight;
        phoneNumber = loginRequest!.number;
      });
    else if (response == kPopupSelectRegister)
      setState(() {
        currentScreen = Screens.REGISTER_SCREEN;
        heightProp = normalHeight;
      });
  }

  void registrationScreenResponse(String response, RegisterRequest request) {
    registerRequest = request;
    if (response == kPopupSelectOTP)
      setState(() {
        currentScreen = Screens.OTP_SCREEN;
        heightProp = otpHeight;
        phoneNumber = registerRequest!.number;
      });
  }

  void otpScreenResponse(String response) {
    if (response == kPopupOTPValid) Navigator.of(context).pop();
  }

  void selectPetScreenResponse(String response) {
    if (true)
      setState(() {
        currentScreen = Screens.PET_INFO_PAGE;
        heightProp = petInfoHeight;
      });
  }

  void petInfoScreenResponse(String response) {
    if (response == kPopupAddedPetList) {
      setState(() {
        currentScreen = Screens.ADDED_PET_PAGE;
        heightProp = selectPetHeight;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (currentScreen) {
      case Screens.WELCOME_SCREEN:
        body = Intro(introScreenResponse: introScreenReponse);
        break;
      case Screens.LOGIN_SCREEN:
        body =
            LoginModal(loginScreenResponse: loginScreenResponse, prefs: prefs);
        break;
      case Screens.REGISTER_SCREEN:
        body = RegisterModal(
            registrationScreenResponse: registrationScreenResponse);
        break;
      case Screens.OTP_SCREEN:
        body = OtpModal(
          requestModel: loginRequest ?? registerRequest!,
          optVerified: otpScreenResponse,
        );
        break;
    }
    SizeConfig().init(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AnimatedContainer(
              duration: Duration(milliseconds: 250),
              height: heightProp,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(22),
                      topRight: Radius.circular(22))),
              child: body),
        ],
      ),
    );
  }

  @override
  void initState() {
    initSharedPreference();
  }

  void initSharedPreference() async {
    prefs = await SharedPreferences.getInstance();
  }
}
