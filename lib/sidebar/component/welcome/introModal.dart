import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_pet_nest/config/sizeConfig.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/paths.dart';

class IntroModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 12.76,
        ),
        Container(
          height: 3,
          width: 38.34,
          color: kAppIconColor,
        ),
        SizedBox(
          height: 45.97,
        ),
        Flexible(
            child: SvgPicture.asset(
          'assets/images/welcome/hero_image.svg',
          width: SizeConfig.blockSizeHorizontal * 72.2,
          height: SizeConfig.blockSizeVertical * 22.2,
        )),
        SizedBox(
          height: 67.55,
        ),
        Text(
          'Pet Grooming - Dog Training\nVet on Call',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: kAppIconColor,
              fontSize: 18,
              height: 1.5,
              fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: 10.79,
        ),
        Text(
          'We Connect Pet Parents with people\nwho`ll treat their Pets like family',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color(0xFF232C63),
              fontSize: 16,
              height: 1.5,
              fontWeight: FontWeight.w300),
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical! * 14.5,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      border: Border.all(color: kAppIconColor)),
                  child: TextButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, kNavigationLogin),
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: kAppIconColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            height: 1.5),
                      )),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: kAppIconColor,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      border: Border.all(color: kAppIconColor)),
                  child: TextButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, kNavigationRegister),
                      child: Text(
                        'Register',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            height: 1.5),
                      )),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical! * 10.87,
        )
      ],
    );
  }
}
