import 'package:equatable/equatable.dart';
import 'package:the_pet_nest/konstants/enums.dart';

class UserProfileState extends Equatable {
  final UpdateState updateState;
  final bool emailValid;
  final bool nameValid;
  final String name;
  final String email;
  final String number;
  final bool processing;

  UserProfileState(
      {this.updateState = UpdateState.IDLE,
      this.emailValid = true,
      this.nameValid = true,
      this.email = '',
      this.name = '',
      this.number = '',
      this.processing = true});

  UserProfileState copyWith(
      {UpdateState? updateState,
      bool? emailValid,
      bool? nameValid,
      String? name,
      String? email,
      String? number,
      bool? processing}) {
    return UserProfileState(
        updateState: updateState ?? this.updateState,
        emailValid: emailValid ?? this.emailValid,
        nameValid: nameValid ?? this.nameValid,
        email: email ?? this.email,
        name: name ?? this.name,
        number: number ?? this.number,
        processing: processing ?? this.processing);
  }

  @override
  List<Object?> get props =>
      [updateState, emailValid, nameValid, email, name, number, processing];
}
