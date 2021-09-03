import 'package:flutter/material.dart';
import 'package:the_pet_nest/konstants/colors.dart';

class FeedbackOptions extends StatelessWidget {
  final bool selected;
  final String text;

  const FeedbackOptions({Key? key, required this.selected, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.62, horizontal: 38.5),
      decoration: BoxDecoration(
          color: selected ? kAppIconColor : Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: kAppIconColor)),
      child: Text(
        text,
        style: TextStyle(color: this.selected ? Colors.white : kAppIconColor),
      ),
    );
  }
}
