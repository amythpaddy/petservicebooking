import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_pet_nest/konstants/styles.dart';

class ServicesCard extends StatelessWidget {
  final String text;
  final String svgPath;

  const ServicesCard({required this.text, required this.svgPath});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 9),
      width: 140,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [kContainerBoxShadow],
            borderRadius: BorderRadius.circular(18)),
        child: Column(
          children: [
            Container(
              height: 58,
              width: 58,
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color.fromARGB(50, 255, 119, 23),
              ),
              child: SvgPicture.asset(svgPath),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
