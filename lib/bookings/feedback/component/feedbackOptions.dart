import 'package:flutter/material.dart';
import 'package:the_pet_nest/konstants/colors.dart';

class FeedbackOptions extends StatelessWidget {
  final int selected;
  final int optionNumber;
  final String text;
  final Function onClick;

  const FeedbackOptions(
      {Key key, this.selected, this.optionNumber, this.text, this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.62, horizontal: 38.5),
        decoration: BoxDecoration(
            color: selected == optionNumber ? kAppIconColor : Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: kAppIconColor)),
        child: Text(
          text,
          style: TextStyle(
              color: this.optionNumber == this.selected
                  ? Colors.white
                  : kAppIconColor),
        ),
      ),
      onPressed: () => onClick(this.optionNumber),
    );
  }
}
