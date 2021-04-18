import 'package:flutter/material.dart';
import 'package:the_pet_nest/konstants.dart';

class MobileLogin extends StatefulWidget {
  @override
  _MobileLoginState createState() => _MobileLoginState();
}

class _MobileLoginState extends State<MobileLogin> {
  bool numberValid = false;
  String number = '';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAppBackgroundColor,
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
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
                      height: 1),
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
                  height: 1),
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
                        height: 1,
                        fontWeight: FontWeight.w400)),
                TextSpan(
                    text: '*',
                    style: TextStyle(
                      color: kAppIconColor,
                    ))
              ])),
            ),
            Container(
              alignment: Alignment.topLeft,
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0x331A202E)),
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    child: Image.asset(
                      'assets/india_icon.png',
                      height: 22.53,
                      width: 33.79,
                    ),
                  ),
                  Text(
                    '+91',
                    style: TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 16, height: 1),
                  ),
                  SizedBox(
                    width: 41,
                    height: 30,
                    child: Container(
                      width: 1,
                      margin: EdgeInsets.symmetric(vertical: 1, horizontal: 20),
                      color: Color(0x331A202E),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(border: InputBorder.none),
                      onChanged: (text) => onPhoneNumberChange(text),
                      style: TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 16, height: 1),
                    ),
                  )
                ],
              ),
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
                onPressed: numberValid
                    ? () => {Navigator.pushNamed(context, kNavigationOtp)}
                    : null,
                child: Text(
                  'Continue',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      height: 1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
