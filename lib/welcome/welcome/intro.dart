import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/values.dart';

class Intro extends StatelessWidget {
  final Function introScreenResponse;

  const Intro({Key? key, required this.introScreenResponse}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // constraints: BoxConstraints.expand(),

      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 12.76,
          ),
          Container(
            height: 2,
            width: 38.34,
            decoration: BoxDecoration(
                color: kAppIconColor, borderRadius: BorderRadius.circular(1)),
          ),
          SizedBox(
            height: 45.96,
          ),
          SvgPicture.asset(
            'assets/images/welcome/hero_image.svg',
            height: 164,
          ),
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
            height: 10.97,
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
            height: 96.91,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 165,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    border: Border.all(color: kAppIconColor)),
                child: TextButton(
                    onPressed: () => introScreenResponse(kPopupSelectLogin),
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: kAppIconColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          height: 1.5),
                    )),
              ),
              SizedBox(
                width: 8,
              ),
              Container(
                width: 165,
                height: 50,
                decoration: BoxDecoration(
                    color: kAppIconColor,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    border: Border.all(color: kAppIconColor)),
                child: TextButton(
                    onPressed: () => introScreenResponse(kPopupSelectRegister),
                    child: Text(
                      'Register',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          height: 1.5),
                    )),
              )
            ],
          ),
          SizedBox(
            height: 17.91,
          )
        ],
      ),
    );
  }
}
