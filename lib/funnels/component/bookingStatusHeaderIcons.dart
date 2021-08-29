import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:the_pet_nest/konstants/styles.dart';

class BookingHeaderIcons extends StatelessWidget {
  const BookingHeaderIcons(
      {Key? key,
      required this.title,
      required this.icon,
      this.iconColor,
      this.onPressed})
      : super(key: key);
  final String title;
  final String icon;
  final Color? iconColor;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kDataContainerStyle,
      child: TextButton(
          onPressed: onPressed ?? () {},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                icon,
                color: iconColor ?? Color(0x77B6B7B9),
              ),
              Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 10,
                    height: 1.5,
                    color: Color(0x771A202E)),
              )
            ],
          )),
    );
  }
}
