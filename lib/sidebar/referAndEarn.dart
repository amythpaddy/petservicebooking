import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/sidebar/component/referralShareComponent.dart';

class ReferAndEarn extends StatelessWidget {
  const ReferAndEarn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kTextColorBlue,
        leading: TextButton(
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: kAppBackgroundAltGray,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 210,
              color: kTextColorBlue,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                children: [
                  Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 30, horizontal: 47),
                      child: Text(
                        'Together, we’re going further!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30,
                            height: 1.2,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      )),
                  ReferralShareComponent(),
                  SizedBox(
                    height: 27,
                  ),
                  Text(
                    'How it works?',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 20, height: 1.5),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                          'assets/images/profile/icon_invitation.svg'),
                      Expanded(
                        child: Text(
                          'Invite pet parents to ThePetNest family!',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              height: 1.5,
                              color: kTextColorBlue),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset('assets/images/profile/icon_signup.svg'),
                      Expanded(
                        child: Text(
                          'They will received a reward of Rs100 on signup',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              height: 1.5,
                              color: kTextColorBlue),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                          'assets/images/profile/icon_invitation.svg'),
                      Expanded(
                        child: Text(
                          'They will received a reward of upto Rs2000 once they book a service',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              height: 1.5,
                              color: kTextColorBlue),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
