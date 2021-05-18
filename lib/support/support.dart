import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_pet_nest/config/sizeConfig.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/styles.dart';
import 'package:the_pet_nest/support/component/supportCard.dart';

class Support extends StatelessWidget {
  const Support({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Support',
          style: kAppBarTitleStyle,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: kAppBackgroundColor,
      ),
      backgroundColor: kAppBackgroundColor,
      body: Column(
        children: [
          SizedBox(height: 62.65),
          SvgPicture.asset(
            'assets/images/support/support_banner.svg',
            height: SizeConfig.blockSizeVertical * 18.23,
            width: SizeConfig.blockSizeHorizontal * 54.93,
          ),
          SizedBox(
            height: 66,
          ),
          SupportCard(
              title: 'Send an Email', image: 'assets/images/support/mail.svg'),
          SupportCard(title: 'Phone', image: 'assets/images/support/phone.svg'),
          SupportCard(
              title: 'Whatsapp', image: 'assets/images/support/whatsapp.svg'),
        ],
      ),
    );
  }
}
