import 'package:flutter/material.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/values.dart';
import 'package:the_pet_nest/welcome/otp/components/OTPTextBox.dart';

class OtpModal extends StatelessWidget {
  final Function optVerified;
  final String phoneNumber;
  FocusNode digit1 = FocusNode();
  FocusNode digit2 = FocusNode();
  FocusNode digit3 = FocusNode();
  FocusNode digit4 = FocusNode();

  OtpModal({Key? key, required this.phoneNumber, required this.optVerified})
      : super(key: key);

  void digit1Changed(String digit) {
    if (digit.length > 0) digit2.requestFocus();
  }

  void digit2Changed(String digit) {
    if (digit.length > 0)
      digit3.requestFocus();
    else
      digit1.requestFocus();
  }

  void digit3Changed(String digit) {
    if (digit.length > 0)
      digit4.requestFocus();
    else
      digit2.requestFocus();
  }

  void digit4Changed(String digit) {
    if (digit.length == 0) digit3.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // constraints: BoxConstraints.expand(),
        margin: EdgeInsets.symmetric(horizontal: 20.5),
        color: Colors.transparent,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            height: 12.76,
          ),
          Container(
            height: 2,
            width: 38.34,
            decoration: BoxDecoration(
                color: kAppIconColor, borderRadius: BorderRadius.circular(1)),
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
            'Check your messages. We`ve sent\nyou the PIN at (+91) $phoneNumber',
            style: TextStyle(
                fontWeight: FontWeight.w400, fontSize: 16, height: 1.5),
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
            onPressed: () => optVerified(kPopupOTPValid),
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
          Container(
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
                'Resend OTP',
                style: TextStyle(
                    color: Color(0xFF232C63),
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    height: 1.5),
              ),
            ),
          ),
        ]));
  }
}
