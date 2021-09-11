import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HowItWorksComponent extends StatelessWidget {
  const HowItWorksComponent(
      {Key? key,
      required this.icon,
      required this.heading,
      required this.detail})
      : super(key: key);
  final String icon;
  final String heading;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(icon),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  heading,
                  style: TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 16, height: 1.5),
                ),
                Text(
                  detail,
                  style: TextStyle(
                      color: Color(0xFF878a92),
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                      height: 1.5),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
