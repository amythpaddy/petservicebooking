import 'package:flutter/material.dart';
import 'package:the_pet_nest/konstants/colors.dart';

class Heading extends StatelessWidget {
  final String heading;
  final bool required;
  final Color color;

  const Heading(
      {Key key, this.heading, this.required, this.color = kHeadingBlack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Text.rich(TextSpan(children: [
      TextSpan(
          text: heading,
          style: TextStyle(
              color: color,
              fontSize: 16,
              height: 1.5,
              fontWeight: FontWeight.w400)),
      required
          ? TextSpan(text: '*', style: TextStyle(color: kAppIconColor))
          : null
    ])));
  }
}
