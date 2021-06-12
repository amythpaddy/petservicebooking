import 'package:flutter/material.dart';
import 'package:the_pet_nest/konstants/colors.dart';

class Heading extends StatelessWidget {
  final String heading;
  final bool required;
  final Color color;

  const Heading(
      {Key? key,
      required this.heading,
      required this.required,
      this.color = kHeadingBlack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: (Text.rich(
        TextSpan(children: [
          TextSpan(
              text: heading,
              style: TextStyle(
                  color: color,
                  fontSize: 16,
                  height: 1.5,
                  fontWeight: FontWeight.w400)),
          TextSpan(
              text: required ? '*' : '', style: TextStyle(color: kAppIconColor))
        ]),
        textAlign: TextAlign.start,
      )),
    );
  }
}
