import 'package:flutter/material.dart';
import 'package:the_pet_nest/bookings/feedback/component/feedbackOptions.dart';

class SwipeQuestionCard extends StatefulWidget {
  final String question;
  final String option1;
  final String option2;
  final String option3;

  SwipeQuestionCard(
      {Key? key,
      required this.question,
      required this.option1,
      required this.option2,
      required this.option3})
      : super(key: key);

  @override
  _SwipeQuestionCardState createState() => _SwipeQuestionCardState();
}

class _SwipeQuestionCardState extends State<SwipeQuestionCard> {
  int selected = 0;

  void updateSelectedOption(optionNumber) {
    setState(() {
      selected = optionNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.question,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
        Wrap(
          alignment: WrapAlignment.center,
          direction: Axis.horizontal,
          children: [
            FeedbackOptions(
              selected: selected,
              optionNumber: 1,
              text: widget.option1,
              onClick: updateSelectedOption,
            ),
            FeedbackOptions(
              selected: selected,
              optionNumber: 2,
              text: widget.option2,
              onClick: updateSelectedOption,
            ),
            FeedbackOptions(
              selected: selected,
              optionNumber: 3,
              text: widget.option3,
              onClick: updateSelectedOption,
            ),
          ],
        )
      ],
    );
  }
}
