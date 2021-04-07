import 'package:flutter/material.dart';

class PetServicesListDisplay extends StatelessWidget {
  final String text;
  final IconData image;

  const PetServicesListDisplay({this.text, this.image});
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
            child: Icon(
              image,
              size: 50,
              color: Color.fromARGB(50, 255, 119, 23),
            ),
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 11,
            ),
          )
        ],
      ),
    );
  }
}
