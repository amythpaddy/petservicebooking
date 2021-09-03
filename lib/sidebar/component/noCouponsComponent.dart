import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/sidebar/component/referralShareComponent.dart';

class NoCouponsComponent extends StatelessWidget {
  const NoCouponsComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 130,
        ),
        SvgPicture.asset('assets/images/sidebar/icon_no_coupon.svg'),
        Text('You have no coupon'),
        SizedBox(
          height: 200,
        ),
        ReferralShareComponent(
          backgroundColor: kAppBackgroundAltGray,
          textColor: Colors.black,
        )
      ],
    );
  }
}
