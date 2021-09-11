import 'package:flutter/material.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/styles.dart';

class VetConsultationComponent extends StatelessWidget {
  const VetConsultationComponent(
      {Key? key,
      required this.heading,
      required this.subText,
      required this.price})
      : super(key: key);
  final String heading;
  final String subText;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18),
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: kDataContainerStyle,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(heading,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.black,
                height: 1.5)),
        Text(
          subText,
          style: TextStyle(
              color: Color(0xFF8c8F96),
              fontSize: 14,
              height: 1.5,
              fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: 48.89,
        ),
        Row(
          children: [
            Expanded(
                child: Text(
              '',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                  fontSize: 16,
                  color: kAppIconColor),
            )),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                  color: Color(0xFFF1F2F2),
                  borderRadius: BorderRadius.circular(38)),
              child: Text(
                'INR $price',
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 13,
                    height: 1.5,
                    color: Colors.black54),
              ),
            ),
            Icon(
              Icons.keyboard_arrow_right_rounded,
              color: kAppIconColor,
            )
          ],
        )
      ]),
    );
  }
}
