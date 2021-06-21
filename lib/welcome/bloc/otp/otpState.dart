class OtpState {
  final bool verifying;
  final bool verifySuccess;
  final bool verifyError;
  final bool canResend;
  final String timeToResend;
  final bool otpRequested;

  OtpState(
      {this.verifying = false,
      this.verifySuccess = false,
      this.verifyError = false,
      this.canResend = false,
      this.timeToResend = '',
      this.otpRequested = true});

  OtpState copyWith(
      {bool? verifying,
      bool? verifySuccess,
      bool? verifyError,
      bool? canResend,
      String? timeToResend,
      bool? otpRequested}) {
    return OtpState(
        verifying: verifying ?? this.verifying,
        verifySuccess: verifySuccess ?? this.verifySuccess,
        verifyError: verifyError ?? this.verifyError,
        canResend: canResend ?? this.canResend,
        timeToResend: timeToResend ?? this.timeToResend,
        otpRequested: otpRequested ?? this.otpRequested);
  }

  @override
  List<Object> get props => [
        verifying,
        verifySuccess,
        verifyError,
        canResend,
        timeToResend,
        otpRequested
      ];
}
