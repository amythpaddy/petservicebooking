import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavigationIcons extends StatelessWidget {
  final Color color;
  final String text;
  final String icon;
  final int? size;
  final Function onPressed;

  const BottomNavigationIcons(
      {required this.color,
      required this.text,
      required this.icon,
      this.size,
      required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onPressed(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            height: 20,
            width: 19,
            color: color,
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                color: color,
                height: 1,
                fontSize: 12),
          )
        ],
      ),
    );
  }
}
