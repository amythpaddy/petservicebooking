import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_pet_nest/konstants/endpoints.dart';
import 'package:the_pet_nest/utils/ApiCaller.dart';
import 'package:the_pet_nest/welcome/bloc/register/registerEvent.dart';
import 'package:the_pet_nest/welcome/bloc/register/registerState.dart';
import 'package:the_pet_nest/welcome/models/registerDataModel.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc(RegisterState initialState) : super(initialState);

  void registerNewUser(RegisterRequest request) async {
    add(RegisterEvent.registerUser);

    var value = await ApiCaller.post(kUrlRegisterSendOTP, request.toJson());
    RegisterResponse response = RegisterResponse.fromJson(value);
    print('${response.data!.expiredAt == null} response');
    if (response.data!.expiredAt == null) {
      add(RegisterEvent.registerNotSuccess);
    } else {
      add(RegisterEvent.registerSuccess);
    }
  }

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event == RegisterEvent.registerUser)
      yield state.copyWith(registering: true);
    else if (event == RegisterEvent.registerSuccess)
      yield state.copyWith(registering: false, registerSuccess: true);
    else if (event == RegisterEvent.registerNotSuccess)
      yield state.copyWith(registering: false, registerError: true);
  }
}
