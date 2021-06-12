import 'package:flutter/material.dart';

class PhoneNumberModule extends StatelessWidget {
  const PhoneNumberModule({required this.onPhoneNumberChange});
  final void Function(String number) onPhoneNumberChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      height: 50,
      decoration: BoxDecoration(
          border: Border.all(color: Color(0x331A202E)),
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            child: Image.asset(
              'assets/images/india_icon.png',
              height: 22.53,
              width: 33.79,
            ),
          ),
          Text(
            '+91',
            style: TextStyle(
                fontWeight: FontWeight.w400, fontSize: 16, height: 1.5),
          ),
          SizedBox(
            width: 41,
            height: 30,
            child: Container(
              width: 1,
              margin: EdgeInsets.symmetric(vertical: 1, horizontal: 20),
              color: Color(0x331A202E),
            ),
          ),
          Expanded(
            child: TextField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(border: InputBorder.none),
              onChanged: (text) => onPhoneNumberChange(text),
              style: TextStyle(
                  fontWeight: FontWeight.w400, fontSize: 16, height: 1.5),
            ),
          )
        ],
      ),
    );
  }
}
