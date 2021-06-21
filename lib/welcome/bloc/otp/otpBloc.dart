import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_pet_nest/konstants/endpoints.dart';
import 'package:the_pet_nest/utils/ApiCaller.dart';
import 'package:the_pet_nest/welcome/bloc/otp/otpEvent.dart';
import 'package:the_pet_nest/welcome/bloc/otp/otpState.dart';
import 'package:the_pet_nest/welcome/models/loginDataModel.dart';
import 'package:the_pet_nest/welcome/models/otpModel.dart';
import 'package:the_pet_nest/welcome/models/registerDataModel.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpBloc(OtpState initialState) : super(initialState) {
    getRemainingTime();
  }
  late String timeRemaining;
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

  verifyRegistrationOtp(RegisterRequest request) async {
    add(OtpEvent.verifyOtp);
    var value = await ApiCaller.post(kUrlRegisterVerifyOTP, request.toJson());
    OtpResponse response = OtpResponse.fromJson(value);
    if (response.data!.success == null) {
      add(OtpEvent.otpVerificationFailed);
    } else {
      _createUserWithOtp(request);
    }
  }

  verifyLoginOtp(LoginRequest request) async {
    add(OtpEvent.verifyOtp);
    var value = await ApiCaller.post(kUrlRegisterVerifyOTP, request.toJson());
    RegisterResponse response = RegisterResponse.fromJson(value);
    if (response.data!.expiredAt == null) {
      add(OtpEvent.otpVerificationFailed);
    } else {
      otpRequested();
    }
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
  }

  void _createUserWithOtp(RegisterRequest request) async {
    var value = await ApiCaller.post(kUrlCreateUserWithOTP, request.toJson());
    RegisterResponse response = RegisterResponse.fromJson(value);
    if (response.data!.expiredAt == null) {
      add(OtpEvent.otpVerificationFailed);
    } else {
      otpRequested();
    }
  }
}
