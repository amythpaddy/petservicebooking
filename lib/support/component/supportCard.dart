import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/styles.dart';

class SupportCard extends StatelessWidget {
  final String title;
  final String image;
  const SupportCard({this.title, this.image, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [kContainerBoxShadow]),
      margin: EdgeInsets.symmetric(horizontal: 20.5, vertical: 5),
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          SvgPicture.asset(
            image,
          ),
          SizedBox(
            width: 6.75,
          ),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  fontWeight: FontWeight.w400,
                  color: kTextColorBlue),
            ),
          ),
          Icon(
            Icons.navigate_next,
            color: kAppIconColor,
          )
        ],
      ),
    );
  }
}
