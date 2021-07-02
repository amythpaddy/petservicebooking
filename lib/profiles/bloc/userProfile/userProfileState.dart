import 'package:the_pet_nest/konstants/enums.dart';

class UserProfileState {
  final UpdateState updateState;
  final bool emailValid;
  final bool nameValid;
  final String name;
  final String email;
  final String number;

  UserProfileState(
      {this.updateState = UpdateState.IDLE,
      this.emailValid = true,
      this.nameValid = true,
      this.email = '',
      this.name = '',
      this.number = ''});

  UserProfileState copyWith(
      {UpdateState? updateState,
      bool? emailValid,
      bool? nameValid,
      String? name,
      String? email,
      String? number}) {
    return UserProfileState(
        updateState: updateState ?? this.updateState,
        emailValid: emailValid ?? this.emailValid,
        nameValid: nameValid ?? this.nameValid,
        email: email ?? this.email,
        name: name ?? this.name,
        number: number ?? this.number);
  }
}
