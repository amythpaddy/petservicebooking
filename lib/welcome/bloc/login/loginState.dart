class LoginState {
  final bool validating;
  final String number;
  final String destinationType;
  final bool openOtp;
  final bool openRegistration;
  final bool numberValid;

  LoginState(
      {this.validating = false,
      this.number = '',
      this.destinationType = 'phone',
      this.openOtp = false,
      this.numberValid = true,
      this.openRegistration = false});

  LoginState copyWith(
      {bool? validating,
      String? number,
      bool? validated,
      bool? numberValid,
      bool? openRegistration}) {
    return LoginState(
        number: number ?? this.number,
        validating: validating ?? this.validating,
        openOtp: validated ?? this.openOtp,
        numberValid: numberValid ?? this.numberValid,
        openRegistration: openRegistration ?? this.openRegistration);
  }

  @override
  List<Object> get props => [
        validating,
        number,
        destinationType,
        openOtp,
        numberValid,
        openRegistration
      ];
}
