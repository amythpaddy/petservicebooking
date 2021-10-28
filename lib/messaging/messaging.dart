import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_pet_nest/konstants/colors.dart';

class Messaging extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: kAppBackgroundAltGray,
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            // SizedBox(
            //   height: 10,
            // ),
            // Text.rich(TextSpan(children: [
            //   TextSpan(text: 'Sort By :'),
            //   TextSpan(text: 'Chat')
            // ])),
            SizedBox(
              height: 30,
            ),
            SvgPicture.asset(
              'assets/images/messages/img_no_msg.svg',
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'No Messages Yet',
              textAlign: TextAlign.center,
            )
          ]),
        ));
  }
}
