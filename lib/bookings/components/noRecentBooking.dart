import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoRecentBookings extends StatelessWidget {
  final String mainText;
  final String subText;

  const NoRecentBookings({required this.mainText, this.subText = ''});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 183),
      child: Column(
        children: [
          SvgPicture.asset(
            'assets/images/bookings/no_bookings.svg',
            width: 151,
            height: 74,
          ),
          SizedBox(
            height: 14.58,
          ),
          Text(
            mainText,
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: 16, height: 1.5),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 6.67,
          ),
          Text(subText,
              style: TextStyle(
                  fontWeight: FontWeight.w400, fontSize: 12, height: 1.5),
              textAlign: TextAlign.center)
        ],
      ),
    );
  }
}
