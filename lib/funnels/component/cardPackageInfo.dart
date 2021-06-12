import 'package:flutter/material.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/styles.dart';

class CardPackageInfo extends StatelessWidget {
  const CardPackageInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.81),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: kTextColorBlue),
          boxShadow: [kContainerBoxShadow],
          color: Colors.white),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(children: [
                Text(
                  'Heading',
                  style: TextStyle(
                      height: 1.5, fontWeight: FontWeight.w500, fontSize: 14),
                ),
                Text.rich(bulletText('Point 1'))
              ]),
              Container(
                height: 66.29,
                margin: EdgeInsets.only(bottom: 14.14, left: 10, right: 10),
                padding: EdgeInsets.symmetric(horizontal: 9.96),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/images/funnels/package_cost_bg.png'),
                        fit: BoxFit.fill)),
                child: Column(
                  children: [
                    Text(
                      'Per Session',
                      style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                    Text(
                      '\u{20B9} 299',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Colors.white),
                    )
                  ],
                ),
              )
            ],
          ),
          Text.rich(TextSpan(children: [
            bulletText('point 2'),
            bulletText('point 2'),
            bulletText('point 2'),
            bulletText('point 2'),
            bulletText('point 2'),
            bulletText('point 2'),
            bulletText('point 2'),
            bulletText('point 2'),
            bulletText('point 2'),
            bulletText('point 2'),
            bulletText('point 2'),
            bulletText('point 2'),
            bulletText('point 2'),
            bulletText('point 2'),
            bulletText('point 2'),
          ])),
          TextButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Value Added',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                        fontSize: 10,
                        color: kTextColorBlue),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right_rounded,
                    color: kAppIconColor,
                  )
                ],
              )),
          SizedBox(
            height: 5,
          ),
          Divider(
            height: 1,
          ),
          SizedBox(
            height: 5,
          ),
          TextButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Requirements',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                        fontSize: 10,
                        color: kTextColorBlue),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right_rounded,
                    color: kAppIconColor,
                  )
                ],
              ))
        ],
      ),
    );
  }

  TextSpan bulletText(String text) {
    return TextSpan(children: [
      TextSpan(text: '\u2022 ', style: TextStyle(color: kAppIconColor)),
      TextSpan(
          text: text,
          style: TextStyle(
              color: kTextColorBlue,
              fontWeight: FontWeight.w300,
              fontSize: 10,
              height: 2.7))
    ]);
  }
}
