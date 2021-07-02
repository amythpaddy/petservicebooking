import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_pet_nest/konstants/dataAccessors.dart';
import 'package:the_pet_nest/konstants/endpoints.dart';
import 'package:the_pet_nest/utils/ApiCaller.dart';
import 'package:the_pet_nest/welcome/bloc/login/loginEvent.dart';
import 'package:the_pet_nest/welcome/bloc/login/loginState.dart';
import 'package:the_pet_nest/welcome/models/loginDataModel.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  late SharedPreferences pref;

  LoginBloc(LoginState initialState) : super(initialState) {
    initSharedPref();
  }

  void initSharedPref() async {
    pref = await SharedPreferences.getInstance();
  }

  void loginWithNumber(String number) async {
    LoginRequest req = LoginRequest(phone: number);
    if (number.length == 10) {
      add(LoginEvent.LoginUserEvent);
      var value = await ApiCaller.post(kUrlLogin, req.toJson());
      LoginResponse response = LoginResponse.fromJson(value);
      if (response.data!.user == null)
        add(LoginEvent.OpenRegistrationEvent);
      else {
        pref.setInt(kDataUserId, response.data!.user!.id!);
        pref.setString(kDataUserFirstName, response.data!.user!.firstName!);
        pref.setString(kDataUserLastName, response.data!.user!.lastName!);
        pref.setString(kDataUserEmail, response.data!.user!.email!);
        pref.setString(kDataUserPhone, response.data!.user!.contactNumber!);

        req.id = response.data!.user!.id!;
        await ApiCaller.post(kUrlLoginSendOTP, req.toJsonForOtpGeneration());
        add(LoginEvent.OpenOTPEvent);
      }
    } else {
      add(LoginEvent.NumberInvalidEvent);
    }
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event == LoginEvent.LoginUserEvent) {
      yield state.copyWith(validating: true, numberValid: true);
    } else if (event == LoginEvent.OpenOTPEvent) {
      yield state.copyWith(validated: true, validating: false);
    } else if (event == LoginEvent.NumberValidEvent) {
      yield state.copyWith(numberValid: true, validating: false);
    } else if (event == LoginEvent.NumberInvalidEvent) {
      yield state.copyWith(numberValid: false, validating: false);
    } else if (event == LoginEvent.OpenRegistrationEvent) {
      yield state.copyWith(openRegistration: true, validating: false);
    }
  }
}
