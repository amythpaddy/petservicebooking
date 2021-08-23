import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_pet_nest/config/sizeConfig.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/styles.dart';

class SelectLocationComponent extends StatelessWidget {
  const SelectLocationComponent(
      {Key? key,
      required this.city,
      required this.address,
      this.selected = false})
      : super(key: key);

  final String city;
  final String address;
  final bool selected;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: !selected ? Colors.white : kAppIconColor,
            boxShadow: [kContainerBoxShadow]),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            SvgPicture.asset(
              'assets/images/funnels/icon_home.svg',
              height: 26,
              width: 26,
              color: selected ? Colors.white : kAppIconColor,
            ),
            SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  city,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                      color: Color(0xFF151724)),
                ),
                Text(
                  address,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  maxLines: 2,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      height: 1.5,
                      color: Color(0xFF0C0F15)),
                )
              ],
            )
          ],
        ));
  }
}
