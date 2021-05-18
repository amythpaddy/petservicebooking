import 'package:flutter/material.dart';
import 'package:the_pet_nest/konstants/colors.dart';

class PetInfo extends StatelessWidget {
  final String heading;
  final String value;
  const PetInfo({Key key, this.heading, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                height: 1.5,
                color: kTextColorBlue),
          ),
          Text(
            value,
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w400, height: 1.5),
          )
        ],
      ),
    );
  }
}
