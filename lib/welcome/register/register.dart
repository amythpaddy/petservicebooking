import 'package:flutter/material.dart';
import 'package:the_pet_nest/konstants.dart';
import 'package:the_pet_nest/welcome/component/phoneNumberModule.dart';

class Register extends StatelessWidget {
  bool numberValid = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAppBackgroundColor,
      ),
      body: Stack(children: [
        Padding(
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
                onPhoneNumberChange: (String number) {},
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
                  onPressed: numberValid
                      ? () => {Navigator.pushNamed(context, kNavigationOtp)}
                      : null,
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
