import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_pet_nest/konstants/colors.dart';

class MenuItem extends StatelessWidget {
  final String icon;
  final String title;

  const MenuItem({Key key, this.icon, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          SvgPicture.asset(icon),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                  color: Color(0xFF232C63),
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  height: 1.5),
            ),
          ),
          Icon(Icons.keyboard_arrow_right, color: kAppIconColor,),
        ],
      ),
    );
  }
}
