import 'package:flutter/material.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/paths.dart';
import 'package:the_pet_nest/profiles/petProfile/component/heading.dart';
import 'package:the_pet_nest/profiles/userProfile/component/userDetailInput.dart';
import 'package:the_pet_nest/welcome/component/phoneNumberModule.dart';

class RegisterModal extends StatefulWidget {
  final Function registrationScreenResponse;

  const RegisterModal({Key? key, required this.registrationScreenResponse})
      : super(key: key);
  @override
  _RegisterModalState createState() =>
      _RegisterModalState(registrationScreenResponse);
}

class _RegisterModalState extends State<RegisterModal> {
  final Function registrationScreenResponse;
  bool nameFilled = false;
  bool emailFilled = false;
  bool numberValid = false;
  String number = '';

  _RegisterModalState(this.registrationScreenResponse);
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
    late String text;
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
                color: kAppIconColor, borderRadius: BorderRadius.circular(1)),
          ),
          SizedBox(
            height: 33.24,
          ),
          Center(
            child: Text(
              'Let`s Register.',
              style: TextStyle(
                  color: kAppIconColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                  height: 1.5),
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
                    height: 1.5)),
          ),
          SizedBox(
            height: 25,
          ),
          UserDetailInput(
            heading: 'Name',
            required: true,
            hint: 'Enter Name',
            onDataFilled: onNameFilled,
          ),
          SizedBox(
            height: 25,
          ),
          UserDetailInput(
            heading: 'Email',
            inputType: TextInputType.emailAddress,
            required: true,
            hint: 'Enter email',
            onDataFilled: onEmailFilled,
          ),
          SizedBox(
            height: 25,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Heading(
              heading: 'Phone Number',
              required: true,
            ),
          ),
          PhoneNumberModule(
            onPhoneNumberChange: (String number) => onPhoneNumberChange(number),
          ),
          SizedBox(
            height: 75,
          ),
          Container(
            height: 50,
            width: double.infinity,
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
                    height: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
