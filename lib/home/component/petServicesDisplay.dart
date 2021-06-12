import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PetServicesListDisplay extends StatelessWidget {
  final String text;
  final String image;

  const PetServicesListDisplay({required this.text, required this.image});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: (size.width / 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: Color.fromARGB(50, 255, 191, 76)),
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
