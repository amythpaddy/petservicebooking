import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_pet_nest/konstants/endpoints.dart';
import 'package:the_pet_nest/utils/ApiCaller.dart';
import 'package:the_pet_nest/welcome/bloc/login/loginEvent.dart';
import 'package:the_pet_nest/welcome/bloc/login/loginState.dart';
import 'package:the_pet_nest/welcome/models/loginDataModel.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(LoginState initialState) : super(initialState);

  void loginWithNumber(String number, BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('loging this in $number'),
      duration: Duration(seconds: 1),
    ));
    add(LoginEvent.NumberValidEvent);
    if (number.length == 10) {
      add(LoginEvent.LoginUserEvent);
      var value =
          await ApiCaller.post(kUrlLogin, LoginRequest(number).toJson());
      if (value['data']['success'] == null)
        add(LoginEvent.OpenRegistrationEvent);
      else
        add(LoginEvent.OpenOTPEvent);
    } else {
      add(LoginEvent.NumberInvalidEvent);
    }
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event == LoginEvent.LoginUserEvent) {
      yield state.copyWith(validating: true);
    } else if (event == LoginEvent.OpenOTPEvent) {
      yield state.copyWith(validated: true);
    } else if (event == LoginEvent.NumberValidEvent) {
      yield state.copyWith(numberValid: true);
    } else if (event == LoginEvent.NumberInvalidEvent) {
      yield state.copyWith(numberValid: false);
    } else if (event == LoginEvent.OpenRegistrationEvent) {
      yield state.copyWith(openRegistration: true);
    }
  }
}
