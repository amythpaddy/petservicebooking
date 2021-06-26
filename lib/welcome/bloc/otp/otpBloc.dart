import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_pet_nest/konstants/dataAccessors.dart';
import 'package:the_pet_nest/konstants/endpoints.dart';
import 'package:the_pet_nest/utils/ApiCaller.dart';
import 'package:the_pet_nest/welcome/bloc/otp/otpEvent.dart';
import 'package:the_pet_nest/welcome/bloc/otp/otpState.dart';
import 'package:the_pet_nest/welcome/models/createUserModel.dart';
import 'package:the_pet_nest/welcome/models/loginDataModel.dart';
import 'package:the_pet_nest/welcome/models/otpModel.dart';
import 'package:the_pet_nest/welcome/models/registerDataModel.dart';
import 'package:the_pet_nest/welcome/models/verifyUserModel.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpBloc(OtpState initialState) : super(initialState) {
    getRemainingTime();
    initSharedPreference();
  }
  void initSharedPreference() async {
    prefs = await SharedPreferences.getInstance();
  }

  late String timeRemaining;
  late SharedPreferences prefs;
  void getRemainingTime() {
    int timeRemaining = 60;
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeRemaining == 0) {
        add(OtpEvent.canResendOtp);
        timer.cancel();
      } else {
        timeRemaining--;
        if (timeRemaining < 10)
          this.timeRemaining = '00:0$timeRemaining';
        else
          this.timeRemaining = '00:$timeRemaining';
        add(OtpEvent.timeToResendChanged);
      }
    });
  }

  void otpRequested() {
    getRemainingTime();
    add(OtpEvent.otpRequested);
  }

  void resendRegistrationOtp(RegisterRequest request) async {
    var value = await ApiCaller.post(kUrlRegisterSendOTP, request.toJson());
    RegisterResponse response = RegisterResponse.fromJson(value);
    if (response.data!.expiredAt == null) {
      add(OtpEvent.otpVerificationFailed);
    } else {
      otpRequested();
    }
  }

  void resendLoginOtp(LoginRequest request) async {
    request.id = prefs.getInt(kDataUserId)!;
    var value = await ApiCaller.post(
        kUrlRegisterSendOTP, request.toJsonForOtpGeneration());
    RegisterResponse response = RegisterResponse.fromJson(value);
    if (response.data!.expiredAt == null) {
      add(OtpEvent.otpVerificationFailed);
    } else {
      otpRequested();
    }
  }

  verifyRegistrationOtp(RegisterRequest request) async {
    add(OtpEvent.verifyOtp);
    var value = await ApiCaller.post(kUrlRegisterVerifyOTP, request.toJson());
    OtpResponse response = OtpResponse.fromJson(value);
    if (response.data!.success == null) {
      add(OtpEvent.otpVerificationFailed);
    } else {
      prefs.setString(kDataUserFirstName, request.firstName);
      prefs.setString(kDataUserLastName, request.lastName);
      prefs.setString(kDataUserEmail, request.email);
      prefs.setString(kDataUserPhone, request.number);
      _createUserWithOtp(request);
    }
  }

  verifyLoginOtp(LoginRequest request) async {
    add(OtpEvent.verifyOtp);
    _loginUser(request);
  }

  @override
  Stream<OtpState> mapEventToState(OtpEvent event) async* {
    if (event == OtpEvent.verifyOtp)
      yield state.copyWith(verifying: true);
    else if (event == OtpEvent.timeToResendChanged)
      yield state.copyWith(timeToResend: timeRemaining);
    else if (event == OtpEvent.canResendOtp)
      yield state.copyWith(canResend: true, otpRequested: false);
    else if (event == OtpEvent.verifyOtp)
      yield state.copyWith(canResend: false);
    else if (event == OtpEvent.otpRequested)
      yield state.copyWith(otpRequested: true, canResend: false);
    else if (event == OtpEvent.verifySuccess)
      yield state.copyWith(verifySuccess: true);
  }

  void _createUserWithOtp(RegisterRequest request) async {
    var value = await ApiCaller.post(kUrlCreateUserWithOTP, request.toJson());
    CreateUserResponse response = CreateUserResponse.fromJson(value);
    if (response.error == null) {
      _loginUser(LoginRequest(phone: request.number, code: request.code));
    } else {
      add(OtpEvent.otpVerificationFailed);
    }
  }

  void _loginUser(LoginRequest request) async {
    var value = await ApiCaller.post(
        kUrlLoginVerifyOTP, request.toJsonForOtpVerification());
    ValidateUserResponse response = ValidateUserResponse.fromJson(value);
    if (response.error == null) {
      //save data to saved preference
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(kDataToken, response.data!.authToken!);
      add(OtpEvent.verifySuccess);
    } else {
      add(OtpEvent.otpVerificationFailed);
    }
  }
}
