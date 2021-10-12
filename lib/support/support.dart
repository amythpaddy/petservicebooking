import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_pet_nest/config/sizeConfig.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/styles.dart';
import 'package:the_pet_nest/support/component/supportCard.dart';
import 'package:the_pet_nest/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class Support extends StatelessWidget {
  const Support({Key? key}) : super(key: key);

  void openSupportEmail(context) async {
    {
      Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: 'help@thepetnest.com',
      );
      await canLaunch(emailLaunchUri.toString())
          ? launch(emailLaunchUri.toString())
          : showSnackbar(context: context);
    }
  }

  void openSupportPhone(context) async {
    {
      Uri emailLaunchUri = Uri(
        scheme: 'tel',
        path: '9354074426',
      );
      await canLaunch(emailLaunchUri.toString())
          ? launch(emailLaunchUri.toString())
          : showSnackbar(context: context);
    }
  }

  void openSupportWhatsapp(context) async {
    const number = '+919354074426';
    const urlAndroid = "whatsapp://send?phone=$number";
    const urlIos = "https://wa.me/$number";
    Platform.isIOS
        ? await canLaunch(urlIos)
            ? launch(urlIos)
            : print('Error')
        : await canLaunch(urlIos)
            ? launch(urlAndroid)
            : showSnackbar(context: context);
  }

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
            title: 'Send an Email',
            image: 'assets/images/support/mail.svg',
            onClick: () => openSupportEmail(context),
          ),
          SupportCard(
              title: 'Phone',
              image: 'assets/images/support/phone.svg',
              onClick: () => openSupportPhone(context)),
          SupportCard(
              title: 'Whatsapp',
              image: 'assets/images/support/whatsapp.svg',
              onClick: () => openSupportWhatsapp(context)),
        ],
      ),
    );
  }
}
