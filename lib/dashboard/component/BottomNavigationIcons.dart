import 'package:flutter/material.dart';

class BottomNavigationIcons extends StatelessWidget {
  final Color color;
  final String text;
  final IconData icon;
  final int size;
  final Function onPressed;

  const BottomNavigationIcons(
      {this.color, this.text, this.icon, this.size, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Column(
        children: [
          Icon(
            icon,
            size: 35,
            color: color,
          ),
          Text(
            text,
            style: TextStyle(fontWeight: FontWeight.w100, color: color),
          )
        ],
      ),
    );
  }
}
