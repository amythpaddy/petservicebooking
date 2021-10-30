import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_pet_nest/konstants/colors.dart';

class PetIssueComponent extends StatelessWidget {
  const PetIssueComponent(
      {Key? key,
      required this.value,
      required this.icon,
      this.color = kTextColorBlue,
      this.size = 20})
      : super(key: key);
  final String value;
  final String icon;
  final Color color;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      margin: EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            value,
            style: TextStyle(
                height: 1.5,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: color),
          ),
          SvgPicture.asset(
            icon,
            height: size,
            width: size,
          )
        ],
      ),
    );
  }
}
