import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/values.dart';
import 'package:the_pet_nest/welcome/bloc/otp/otpBloc.dart';
import 'package:the_pet_nest/welcome/bloc/otp/otpState.dart';
import 'package:the_pet_nest/welcome/models/baseRequestModal.dart';
import 'package:the_pet_nest/welcome/models/loginDataModel.dart';
import 'package:the_pet_nest/welcome/models/registerDataModel.dart';
import 'package:the_pet_nest/welcome/otp/components/OTPTextBox.dart';

class OtpModal extends StatelessWidget {
  final Function optVerified;
  final BaseRequestModel requestModel;
  FocusNode digit1 = FocusNode();
  FocusNode digit2 = FocusNode();
  FocusNode digit3 = FocusNode();
  FocusNode digit4 = FocusNode();
  List code = ["", "", "", ""];

  OtpModal({Key? key, required this.requestModel, required this.optVerified})
      : super(key: key);

  void digit1Changed(String digit) {
    code[0] = digit;
    if (digit.length > 0) digit2.requestFocus();
  }

  void digit2Changed(String digit) {
    code[1] = digit;
    if (digit.length > 0)
      digit3.requestFocus();
    else
      digit1.requestFocus();
  }

  void digit3Changed(String digit) {
    code[2] = digit;
    if (digit.length > 0)
      digit4.requestFocus();
    else
      digit2.requestFocus();
  }

  void digit4Changed(String digit) {
    code[3] = digit;
    if (digit.length == 0) digit3.requestFocus();
  }

  OtpBloc _otpBloc = OtpBloc(OtpState());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _otpBloc,
      child: BlocListener<OtpBloc, OtpState>(
        listener: (context, OtpState state) {
          if (state.verifySuccess) {
            optVerified(kPopupOTPValid);
          }
        },
        child: BlocBuilder(
            bloc: _otpBloc,
            builder: (context, OtpState state) {
              return Container(
                  // constraints: BoxConstraints.expand(),
                  margin: EdgeInsets.symmetric(horizontal: 20.5),
                  color: Colors.transparent,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 12.76,
                        ),
                        Container(
                          height: 2,
                          width: 38.34,
                          decoration: BoxDecoration(
                              color: kAppIconColor,
                              borderRadius: BorderRadius.circular(1)),
                        ),
                        SizedBox(
                          height: 33.24,
                        ),
                        Text(
                          'OTP Verification',
                          style: TextStyle(
                              color: kAppIconColor,
                              fontSize: 24,
                              height: 1.5,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 5.23,
                        ),
                        Text(
                          'Check your messages. We`ve sent\nyou the PIN at (+91) ${requestModel.number}',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              height: 1.5),
                        ),
                        SizedBox(
                          height: 66,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            OTPTextBox(
                              focusNode: digit1,
                              onOTPChanged: digit1Changed,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            OTPTextBox(
                              focusNode: digit2,
                              onOTPChanged: digit2Changed,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            OTPTextBox(
                              focusNode: digit3,
                              onOTPChanged: digit3Changed,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            OTPTextBox(
                              focusNode: digit4,
                              onOTPChanged: digit4Changed,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 114,
                        ),
                        TextButton(
                          onPressed: () {
                            StringBuffer otp = StringBuffer();
                            code.forEach((element) {
                              otp.write(element);
                            });
                            print(otp.toString());
                            if (otp.toString().trim().length == 4) {
                              requestModel.code = otp.toString();
                              if (requestModel.type == 'login_request')
                                _otpBloc.verifyLoginOtp(
                                    requestModel as LoginRequest);
                              else
                                _otpBloc.verifyRegistrationOtp(
                                    requestModel as RegisterRequest);
                            }
                          },
                          child: Container(
                            height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 18),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                              color: kAppIconColor,
                            ),
                            child: Center(
                              child: Text(
                                'Verify',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    height: 1.5),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        TextButton(
                          onPressed: () {
                            if (state.canResend) {
                              if (requestModel.type == 'register_request')
                                _otpBloc.resendRegistrationOtp(
                                    requestModel as RegisterRequest);
                              else
                                _otpBloc.resendLoginOtp(
                                    requestModel as LoginRequest);
                            }
                          },
                          child: Container(
                            height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 18),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                              border: Border.all(color: Color(0xFF232C63)),
                            ),
                            child: Center(
                              child: Text(
                                state.canResend
                                    ? 'Resend OTP'
                                    : state.timeToResend,
                                style: TextStyle(
                                    color: Color(0xFF232C63),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    height: 1.5),
                              ),
                            ),
                          ),
                        ),
                      ]));
            }),
      ),
    );
  }
}
