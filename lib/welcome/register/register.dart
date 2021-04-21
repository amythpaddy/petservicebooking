import 'package:flutter/material.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/paths.dart';
import 'package:the_pet_nest/welcome/component/phoneNumberModule.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool nameFilled = false;
  bool emailFilled = false;
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
      number;
    });
  }

  void onNameFilled(String name) {
    setState(() {
      nameFilled = name.length > 0 ? true : false;
    });
  }

  void onEmailFilled(String email) {
    setState(() {
      emailFilled = email.length > 0 ? true : false;
    });
  }

  @override
  Widget build(BuildContext context) {
    String text;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAppBackgroundColor,
      ),
      body: Stack(children: [
        Container(
          color: kAppBackgroundColor,
          padding: const EdgeInsets.only(left: 18.0, right: 18, top: 42),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              Center(
                child: Text(
                  'Let`s Register.',
                  style: TextStyle(
                      color: kAppIconColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                      height: 1),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: Text('Welcome!',
                    style: TextStyle(
                        color: Color(0xFF232C63),
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        height: 1)),
              ),
              SizedBox(
                height: 25,
              ),
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: 'Name',
                    style: TextStyle(
                        color: Color(0xFF1A202E),
                        fontSize: 16,
                        height: 1,
                        fontWeight: FontWeight.w400)),
                TextSpan(text: '*', style: TextStyle(color: kAppIconColor))
              ])),
              TextField(
                onChanged: onNameFilled,
                decoration: InputDecoration(
                  focusColor: Color(0x331A202E),
                  hintText: 'Enter name',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0x331A202E)),
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: 'Email',
                    style: TextStyle(
                        color: Color(0xFF1A202E),
                        fontSize: 16,
                        height: 1,
                        fontWeight: FontWeight.w400)),
                TextSpan(text: '*', style: TextStyle(color: kAppIconColor))
              ])),
              TextField(
                onChanged: onEmailFilled,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  focusColor: Color(0x331A202E),
                  hintText: 'Enter email',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0x331A202E)),
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: 'Phone Number',
                    style: TextStyle(
                        color: Color(0xFF1A202E),
                        fontSize: 16,
                        height: 1,
                        fontWeight: FontWeight.w400)),
                TextSpan(text: '*', style: TextStyle(color: kAppIconColor))
              ])),
              PhoneNumberModule(
                onPhoneNumberChange: (String number) =>
                    onPhoneNumberChange(number),
              ),
              SizedBox(
                height: 75,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color(0xFFff7716),
                ),
                child: TextButton(
                  onPressed: numberValid && nameFilled && emailFilled
                      ? () => {
                            Navigator.pushNamed(context, kNavigationOtp,
                                arguments: number)
                          }
                      : () => {
                            if (!nameFilled)
                              {text = 'Name is Mandatory'}
                            else if (!emailFilled)
                              {text = 'Email is Mandatory'}
                            else if (!numberValid)
                              {text = 'Phone Number Should be of 10 digit '},
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(text),
                              duration: Duration(seconds: 1),
                            ))
                          },
                  child: Text(
                    'Register',
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
        Container(
          height: 3,
          color: kAppIconColor,
          width: MediaQuery.of(context).size.width * .5,
        ),
      ]),
    );
  }
}
