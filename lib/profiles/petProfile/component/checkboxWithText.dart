import 'package:flutter/material.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/profiles/petProfile/component/outlineCheckbox.dart';

class CheckboxWithText extends StatelessWidget {
  final bool selected;
  final String title;
  final Function onChanged;

  const CheckboxWithText(
      {Key? key,
      required this.selected,
      required this.title,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onChanged,
      child: Row(
        children: [
          OutlineCheckbox(
            selected: selected,
          ),
          SizedBox(
            width: 9,
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: 16,
                height: 1.5,
                fontWeight: FontWeight.w400,
                color: kHeadingBlack),
          )
        ],
      ),
    );
  }
}
