import 'package:flutter/material.dart';

class PackageTypeSelector extends StatelessWidget {
  final BoxDecoration? boxDecoration;
  final void Function() onPressed;
  final String title;
  final TextStyle textStyle;

  const PackageTypeSelector(
      {Key? key,
      this.boxDecoration,
      required this.onPressed,
      required this.title,
      required this.textStyle})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 114,
        decoration: boxDecoration,
        child: TextButton(
            onPressed: onPressed,
            child: Text(
              'In-Home',
              style: textStyle,
            )));
  }
}
