import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WhyDogTrainingComponent extends StatelessWidget {
  const WhyDogTrainingComponent(
      {Key? key,
      required this.image,
      required this.heading,
      required this.detail})
      : super(key: key);
  final String image;
  final String heading;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 68,
          width: 68,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(34)),
          child: SvgPicture.asset(
            image,
          ),
        ),
        Text(
          heading,
          style:
              TextStyle(fontWeight: FontWeight.w600, fontSize: 10, height: 1.5),
        ),
        Text(
          detail,
          style:
              TextStyle(fontWeight: FontWeight.w400, fontSize: 10, height: 1.5),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
