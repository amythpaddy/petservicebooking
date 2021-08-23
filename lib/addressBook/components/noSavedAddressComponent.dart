import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NoSavedAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/images/bookings/no_bookings.svg',
          width: 151,
          height: 74,
        ),
        Text(
          'No Addresses Added',
          style:
              TextStyle(fontWeight: FontWeight.w600, fontSize: 16, height: 1.5),
        )
      ],
    ));
  }
}
