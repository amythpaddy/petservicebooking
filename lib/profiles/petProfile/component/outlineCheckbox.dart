import 'package:flutter/material.dart';
import 'package:the_pet_nest/konstants/colors.dart';

class OutlineCheckbox extends StatelessWidget {
  final bool selected;

  const OutlineCheckbox({
    Key? key,
    this.selected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 18,
      width: 18,
      decoration: BoxDecoration(
          border: Border.all(color: kAppIconColor),
          borderRadius: BorderRadius.circular(6)),
      child: Icon(
        Icons.check,
        size: 17,
        color: selected ? kTextColorBlue : Colors.white,
      ),
    );
  }
}
