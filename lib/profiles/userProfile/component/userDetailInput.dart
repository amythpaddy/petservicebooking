import 'package:flutter/material.dart';
import 'package:the_pet_nest/konstants/colors.dart';

class UserDetailInput extends StatelessWidget {
  final String heading;
  final String hint;
  final bool required;
  final TextInputType inputType;
  final Function onDataFilled;
  final String value;

  const UserDetailInput({this.heading, this.hint, this.required = false, this.inputType = TextInputType
          .text, this.onDataFilled, this.value='',Key key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController()..text = value;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(TextSpan(children: [
          TextSpan(
              text: heading,
              style: TextStyle(
                  color: Color(0xFF1A202E),
                  fontSize: 16,
                  height: 1.5,
                  fontWeight: FontWeight.w400)),
          required
              ? TextSpan(text: '*', style: TextStyle(color: kAppIconColor))
              : null
        ])),
        TextField(
          controller: _controller,
          onChanged: onDataFilled,
          decoration: InputDecoration(
            focusColor: Color(0x331A202E),
            hintText: hint,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0x331A202E)),
                borderRadius: BorderRadius.all(Radius.circular(12))),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0x331A202E)),
                borderRadius: BorderRadius.all(Radius.circular(12))),
          ),
        ),
      ],
    );
  }
}
