class RegisterState {
  final bool registering;
  final bool registerSuccess;
  final bool registerError;
  RegisterState(
      {this.registering = false,
      this.registerSuccess = false,
      this.registerError = false});

  RegisterState copyWith(
      {bool? registering, bool? registerSuccess, bool? registerError}) {
    return RegisterState(
        registering: registering ?? this.registering,
        registerSuccess: registerSuccess ?? this.registerSuccess,
        registerError: registerError ?? this.registerError);
  }

  @override
  List<Object> get props => [registering, registerSuccess, registerError];
}
