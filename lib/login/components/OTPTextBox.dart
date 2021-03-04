import 'package:flutter/material.dart';

class OTPTextBox extends StatelessWidget {
  OTPTextBox({this.onOTPChanged, this.focusNode});
  final void Function(String otp) onOTPChanged;
  final FocusNode focusNode;

  void onChanged(String change) {
    onOTPChanged(change);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 50, 10, 50),
      width: 80,
      child: TextField(
        decoration:
            InputDecoration(border: OutlineInputBorder(), counterText: ""),
        maxLength: 1,
        keyboardType: TextInputType.number,
        onChanged: onChanged,
        focusNode: focusNode,
      ),
    );
  }
}
