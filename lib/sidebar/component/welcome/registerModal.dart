import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/paths.dart';
import 'package:the_pet_nest/konstants/values.dart';
import 'package:the_pet_nest/profiles/petProfile/component/heading.dart';
import 'package:the_pet_nest/profiles/userProfile/component/userDetailInput.dart';
import 'package:the_pet_nest/welcome/bloc/register/registerBloc.dart';
import 'package:the_pet_nest/welcome/bloc/register/registerState.dart';
import 'package:the_pet_nest/welcome/component/phoneNumberModule.dart';
import 'package:the_pet_nest/welcome/models/registerDataModel.dart';

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
  String name = '';
  String email = '';

  _RegisterModalState(this.registrationScreenResponse);
  void onPhoneNumberChange(String number) {
    this.number = number;
    numberValid = number.length == 10 ? true : false;
  }

  void onNameFilled(String name) {
    print(name);
    this.name = name;
    setState(() {
      nameFilled = name.length > 0 ? true : false;
    });
  }

  void onEmailFilled(String email) {
    this.email = email;
    setState(() {
      emailFilled = email.length > 0 ? true : false;
    });
  }

  RegisterBloc _registerBloc = RegisterBloc(RegisterState());
  @override
  Widget build(BuildContext context) {
    late String text;
    return BlocProvider(
      create: (_) => _registerBloc,
      child: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state.registerSuccess) {
            registrationScreenResponse(
                kPopupSelectOTP,
                RegisterRequest(
                    firstName: name,
                    lastName: '',
                    number: number,
                    email: email));
            Navigator.pushNamed(context, kNavigationOtp,
                arguments: RegisterRequest(
                  firstName: name,
                  lastName: '',
                  number: number,
                  email: email,
                ));
          }
          if (state.registerError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Something went wrong. Try again later.'),
              duration: Duration(seconds: 2),
            ));
          }
        },
        child: BlocBuilder(
            bloc: _registerBloc,
            builder: (context, RegisterState state) {
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
                      onPhoneNumberChange: (String number) =>
                          onPhoneNumberChange(number),
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
                        onPressed: numberValid &&
                                nameFilled &&
                                emailFilled &&
                                !state.registering
                            ? () =>
                                _registerBloc.registerNewUser(RegisterRequest(
                                  firstName: name,
                                  lastName: '',
                                  number: number,
                                  email: email,
                                ))
                            : () => {
                                  if (!nameFilled)
                                    {text = 'Name is Mandatory'}
                                  else if (!emailFilled)
                                    {text = 'Email is Mandatory'}
                                  else if (!numberValid)
                                    {
                                      text =
                                          'Phone Number Should be of 10 digit '
                                    },
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
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
            }),
      ),
    );
  }
}
