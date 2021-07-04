import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_pet_nest/profiles/petProfile/component/checkboxWithText.dart';

class PetSelectCheckBox extends StatelessWidget {
  const PetSelectCheckBox(
      {Key? key,
      required this.title,
      required this.selected,
      required this.onChanged,
      required this.image})
      : super(key: key);
  final String title;
  final bool selected;
  final Function onChanged;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(image),
        CheckboxWithText(title: title, selected: selected, onChanged: onChanged)
      ],
    );
  }
}
