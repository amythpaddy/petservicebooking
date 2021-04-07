import 'package:flutter/material.dart';
import 'package:the_pet_nest/konstants.dart';
import 'package:the_pet_nest/login/components/OTPTextBox.dart';

class MobileLogin extends StatefulWidget {
  @override
  _MobileLoginState createState() => _MobileLoginState();
}

class _MobileLoginState extends State<MobileLogin> {
  bool numberValid = false;
  String number = '';
  bool enterOtp = false;

  FocusNode digit1;
  FocusNode digit2;
  FocusNode digit3;
  FocusNode digit4;

  @override
  void initState() {
    super.initState();
    digit1 = FocusNode();
    digit2 = FocusNode();
    digit3 = FocusNode();
    digit4 = FocusNode();
  }

  @override
  void dispose() {
    digit1.dispose();
    digit2.dispose();
    digit3.dispose();
    digit4.dispose();
    super.dispose();
  }

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
    print(number);
  }

  void digit1Changed(String digit) {
    if (digit.length > 0) digit2.requestFocus();
  }

  void digit2Changed(String digit) {
    if (digit.length > 0)
      digit3.requestFocus();
    else
      digit1.requestFocus();
  }

  void digit3Changed(String digit) {
    if (digit.length > 0)
      digit4.requestFocus();
    else
      digit2.requestFocus();
  }

  void digit4Changed(String digit) {
    if (digit.length == 0) digit3.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/login_bg.jpg'), fit: BoxFit.cover),
        ),
        child: Stack(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 80),
                  child: Image.asset('assets/the_pet_nest.png')),
              SizedBox(
                height: 50,
              ),
              Text('Your Pet Parenting Partner'),
              SizedBox(
                height: 50,
              ),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black12)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          child: Image.asset(
                            'assets/india_icon.png',
                            height: 50,
                            width: 40,
                          ),
                        ),
                        Text(
                          '+91  ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12)),
                      width: 200,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(border: InputBorder.none),
                        onChanged: (text) => onPhoneNumberChange(text),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 85),
                color: Color(0xFFff7716),
                onPressed: numberValid ? sendOtp : null,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              FlatButton(
                onPressed: () => skipScreen(context),
                child: Text(
                  'Skip',
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
          Visibility(
            visible: enterOtp,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(color: Color.fromARGB(150, 0, 0, 0)),
            ),
          ),
          Visibility(
            visible: enterOtp,
            child: Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                alignment: Alignment.bottomCenter,
                height: 250,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OTPTextBox(
                          onOTPChanged: digit1Changed,
                          focusNode: digit1,
                        ),
                        OTPTextBox(
                            onOTPChanged: digit2Changed, focusNode: digit2),
                        OTPTextBox(
                            onOTPChanged: digit3Changed, focusNode: digit3),
                        OTPTextBox(
                            onOTPChanged: digit4Changed, focusNode: digit4),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      decoration: BoxDecoration(
                          color: Colors.black87,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: FlatButton(
                        onPressed: () {},
                        child: Text(
                          'OK',
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }

  sendOtp() {
    enterOtp = true;
    setState(() {
      enterOtp;
    });
  }

  resetNumber() {
    enterOtp = false;
    setState(() {
      enterOtp;
    });
  }

  skipScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, kNavigationHome);
  }
}
