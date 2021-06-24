import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/dataAccessors.dart';
import 'package:the_pet_nest/konstants/values.dart';
import 'package:the_pet_nest/welcome/bloc/login/loginBloc.dart';
import 'package:the_pet_nest/welcome/bloc/login/loginState.dart';
import 'package:the_pet_nest/welcome/component/phoneNumberModule.dart';
import 'package:the_pet_nest/welcome/models/loginDataModel.dart';

class LoginModal extends StatefulWidget {
  final Function loginScreenResponse;
  final SharedPreferences prefs;

  const LoginModal(
      {Key? key, required this.loginScreenResponse, required this.prefs})
      : super(key: key);
  @override
  _LoginModalState createState() =>
      _LoginModalState(loginScreenResponse, prefs);
}

class _LoginModalState extends State<LoginModal> {
  bool numberValid = false;
  String number = '';
  SharedPreferences prefs;
  final Function loginScreenResponse;

  _LoginModalState(this.loginScreenResponse, this.prefs);
  void onPhoneNumberChange(String number) {
    if (number.length == 10)
      numberValid = true;
    else
      numberValid = false;
    this.number = number;
    setState(() {
      numberValid;
      this.number;
    });
  }

  LoginBloc _loginBloc = LoginBloc(LoginState());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _loginBloc,
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (!state.numberValid) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Phone Number Should be of 10 digit '),
              duration: Duration(seconds: 2),
            ));
          }
          if (state.openOtp) {
            loginScreenResponse(kPopupSelectOTP,
                LoginRequest(phone: number, id: prefs.getInt(kDataUserId)));
          }
          if (state.openRegistration) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Number not registered. Register to continue.'),
              duration: Duration(seconds: 3),
            ));
            loginScreenResponse(kPopupSelectRegister,
                LoginRequest(phone: number, id: prefs.getInt(kDataUserId)));
          }
        },
        child: BlocBuilder(
          bloc: _loginBloc,
          builder: (context, LoginState state) {
            return Container(
              // constraints: BoxConstraints.expand(),
              margin: EdgeInsets.symmetric(horizontal: 20.5),
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 12.76,
                  ),
                  Container(
                    height: 2,
                    width: 38.34,
                    decoration: BoxDecoration(
                        color: kAppIconColor,
                        borderRadius: BorderRadius.circular(1)),
                  ),
                  SizedBox(
                    height: 22.24,
                  ),
                  Text(
                    'Let`s sign you in',
                    style: TextStyle(
                        color: kAppIconColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        height: 1.5),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Welcome Back!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xFF232C63),
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        height: 1.5),
                  ),
                  SizedBox(
                    height: 51.59,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text.rich(TextSpan(children: [
                      TextSpan(
                          text: 'Phone Number',
                          style: TextStyle(
                              color: Color(0xFF1A202E),
                              fontSize: 16,
                              height: 1.5,
                              fontWeight: FontWeight.w400)),
                      TextSpan(
                          text: '*',
                          style: TextStyle(
                            color: kAppIconColor,
                          ))
                    ])),
                  ),
                  PhoneNumberModule(
                    onPhoneNumberChange: onPhoneNumberChange,
                  ),
                  SizedBox(
                    height: 88.38,
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color(0xFFff7716),
                    ),
                    child: TextButton(
                      onPressed: () => _loginBloc.loginWithNumber(number),
                      child: Text(
                        'Continue',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            height: 1.5),
                      ),
                    ),
                  ),
                  SizedBox(height: 17.79),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text('Did’t have a account let’s',
                        style: TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            fontWeight: FontWeight.w400,
                            color: kTextColorBlue)),
                    TextButton(
                        onPressed: () =>
                            loginScreenResponse(kPopupSelectRegister, ''),
                        child: Text('Register',
                            style: TextStyle(
                                fontSize: 14,
                                height: 1.5,
                                color: kAppIconColor,
                                fontWeight: FontWeight.w600)))
                  ])
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
