import 'package:flutter/material.dart';
import 'package:the_pet_nest/konstants/colors.dart';

class OptionsChip extends StatelessWidget {
  final String title;
  final bool selected;
  final Function onSelected;
  const OptionsChip(
      {Key? key,
      required this.title,
      this.selected = false,
      required this.onSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(51),
          border: Border.all(color: selected ? kAppIconColor : Colors.black38)),
      child: TextButton(
        style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4.5)),
        onPressed: () {
          onSelected();
        },
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: selected ? kAppIconColor : Colors.black38),
        ),
      ),
    );
  }
}
