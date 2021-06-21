import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/paths.dart';
import 'package:the_pet_nest/welcome/bloc/login/loginBloc.dart';
import 'package:the_pet_nest/welcome/bloc/login/loginState.dart';
import 'package:the_pet_nest/welcome/component/phoneNumberModule.dart';
import 'package:the_pet_nest/welcome/models/loginDataModel.dart';

class MobileLogin extends StatefulWidget {
  @override
  _MobileLoginState createState() => _MobileLoginState();
}

class _MobileLoginState extends State<MobileLogin> {
  LoginBloc _loginBloc = LoginBloc(LoginState());
  String number = '';
  void onPhoneNumberChange(String number) {
    setState(() {
      this.number = number;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kAppBackgroundColor,
        ),
        resizeToAvoidBottomInset: false,
        body: BlocProvider(
          create: (_) => _loginBloc,
          child: BlocListener<LoginBloc, LoginState>(
              listener: (blocContext, state) {
                if (!state.numberValid) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Phone Number Should be of 10 digit '),
                    duration: Duration(seconds: 2),
                  ));
                }
                if (state.openOtp) {
                  Navigator.pushNamed(context, kNavigationOtp,
                      arguments: LoginRequest(number));
                }
                if (state.openRegistration) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content:
                        Text('Number not registered. Register to continue.'),
                    duration: Duration(seconds: 3),
                  ));
                  Navigator.pushNamed(context, kNavigationRegister,
                      arguments: number);
                }
              },
              child: BlocBuilder(
                bloc: _loginBloc,
                builder: (blockContext, LoginState state) {
                  return Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 19),
                        constraints: BoxConstraints.expand(),
                        color: kAppBackgroundColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Center(
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: 52,
                                ),
                                child: Text(
                                  'Let`s sign you in',
                                  style: TextStyle(
                                      color: kAppIconColor,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                      height: 1.5),
                                ),
                              ),
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
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Color(0xFFff7716),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  if (!state.validating) {
                                    _loginBloc.loginWithNumber(number, context);
                                  }
                                },
                                child: state.validating
                                    ? CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : Text(
                                        'Continue',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                            height: 1.5),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 3,
                        color: kAppIconColor,
                        width: MediaQuery.of(context).size.width * .5,
                      ),
                    ],
                  );
                },
              )),
        ));
  }
}
