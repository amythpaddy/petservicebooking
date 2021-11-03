import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_pet_nest/konstants/styles.dart';

class ServicesCard extends StatelessWidget {
  final String text;
  final String svgPath;
  final void Function() onClick;
  final bool marginRight;

  const ServicesCard(
      {required this.text,
      required this.svgPath,
      required this.onClick,
      this.marginRight = true});
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
      onPressed: onClick,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [kContainerBoxShadow],
            borderRadius: BorderRadius.circular(18)),
        margin: EdgeInsets.only(right: marginRight ? 9 : 0),
        padding: EdgeInsets.only(bottom: 10, left: 9, right: 9),
        child: Column(
          children: [
            Container(
              height: 58,
              width: 58,
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color(0xFFFFF5EF),
              ),
              child: SvgPicture.asset(svgPath),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: Text(
                text,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11,
                    color: Color(0xFF151724)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
