import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_pet_nest/konstants/colors.dart';

class NutritionistConsultationDetailComponent extends StatelessWidget {
  const NutritionistConsultationDetailComponent(
      {Key? key, required this.image, required this.title, required this.price})
      : super(key: key);
  final String image;
  final String title;
  final String price;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(image),
        SizedBox(
          width: 10.5,
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  height: 1.5,
                  color: Colors.black),
            ),
            Text(
              'INR $price',
              style: TextStyle(
                  color: Color(0xFF8C8F96),
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                  height: 1.5),
            )
          ],
        )),
        Icon(
          Icons.keyboard_arrow_right_rounded,
          color: kAppIconColor,
        )
      ],
    );
  }
}
