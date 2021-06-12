import 'package:flutter/material.dart';

class OTPTextBox extends StatelessWidget {
  OTPTextBox({required this.onOTPChanged, required this.focusNode});
  final void Function(String otp) onOTPChanged;
  final FocusNode focusNode;

  void onChanged(String change) {
    onOTPChanged(change);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 50,
      child: Center(
        child: TextField(
          decoration: InputDecoration(
              focusColor: Color(0x331A202E),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0x331A202E)),
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              counterText: ""),
          maxLength: 1,
          keyboardType: TextInputType.number,
          onChanged: onChanged,
          focusNode: focusNode,
        ),
      ),
    );
  }
}
