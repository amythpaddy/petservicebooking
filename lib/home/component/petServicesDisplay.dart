import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PetServicesListDisplay extends StatelessWidget {
  final String text;
  final String image;

  const PetServicesListDisplay({required this.text, required this.image});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            child: SvgPicture.asset(image),
          ),
          SizedBox(
            height: 8.95,
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w400, fontSize: 11, height: 1.5),
          )
        ],
      ),
    );
  }
}
