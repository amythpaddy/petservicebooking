import 'package:flutter/material.dart';
import 'package:the_pet_nest/bookings/feedback/component/feedbackOptions.dart';
import 'package:the_pet_nest/bookings/feedback/model/feedbackInternalModel.dart';

class SwipeQuestionCard extends StatelessWidget {
  final String question;
  final String optionSelected;
  final dynamic options;
  final bool editable;
  final Function(String question, String answer) onOptionSelected;
  final List<Widget> wrapChildren = [];

  SwipeQuestionCard(
      {Key? key,
      required this.question,
      required this.options,
      required this.editable,
      required this.optionSelected,
      required this.onOptionSelected})
      : super(key: key) {
    if (editable) {
      print(options);
      options.forEach((Options option) {
        wrapChildren.add(
          TextButton(
            onPressed: () => onOptionSelected(question, option.value),
            child: FeedbackOptions(
              selected: option.value == optionSelected,
              text: option.value,
            ),
          ),
        );
      });
    } else {
      wrapChildren.add(
        FeedbackOptions(
          selected: options == optionSelected,
          text: options,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          question,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
        Wrap(
          alignment: WrapAlignment.center,
          direction: Axis.horizontal,
          children: wrapChildren,
        )
      ],
    );
  }
}
