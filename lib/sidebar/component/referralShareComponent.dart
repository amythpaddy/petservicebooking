import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_pet_nest/config/sizeConfig.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/dataAccessors.dart';
import 'package:the_pet_nest/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class ReferralShareComponent extends StatelessWidget {
  const ReferralShareComponent(
      {Key? key,
      this.backgroundColor = kAppIconColor,
      this.textColor = Colors.white})
      : super(key: key);
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.blockSizeHorizontal * 100,
      padding: EdgeInsets.only(top: 15, bottom: 27),
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Text(
            'Refer and Get Free Services ',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                height: 1.5,
                color: textColor),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            'They get Rs100 on Signup,\n You win upto Rs2000 when they take their first service',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                height: 1.5,
                color: textColor),
          ),
          SizedBox(
            height: 22,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
                onPressed: () async {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  var urlAndroid =
                      "whatsapp://send?text=Use the referral code ${pref.getString(kDataUserReferral) ?? ""}";
                  var urlIos =
                      "https://wa.me/?text=Use the referral code ${pref.getString(kDataUserReferral) ?? ""}";
                  Platform.isIOS
                      ? await canLaunch(urlIos)
                          ? launch(urlIos)
                          : print('Error')
                      : await canLaunch(urlIos)
                          ? launch(urlAndroid)
                          : showSnackbar(context: context);
                },
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.white),
                  child: Image.asset('assets/images/profile/icon_whatsapp.png'),
                ),
              ),
              SizedBox(
                width: 40,
              ),
              TextButton(
                onPressed: () async {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  Share.share(
                      'Use referral code ${pref.getString(kDataUserReferral) ?? ''}');
                },
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.white),
                  child: Image.asset('assets/images/profile/icon_facebook.png'),
                ),
              ),
              SizedBox(
                width: 40,
              ),
              TextButton(
                onPressed: () async {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  Clipboard.setData(ClipboardData(
                      text:
                          'Use Referral Code ${pref.getString(kDataUserReferral) ?? ''}'));
                  showSnackbar(
                      context: context, message: 'Referral Code Copied');
                },
                child: Container(
                  width: 48,
                  height: 48,
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.white),
                  child: SvgPicture.asset(
                      'assets/images/profile/icon_share_link.svg'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
