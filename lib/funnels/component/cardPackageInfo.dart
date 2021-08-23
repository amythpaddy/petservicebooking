import 'package:flutter/material.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/enums.dart';
import 'package:the_pet_nest/konstants/styles.dart';

class CardPackageInfo extends StatelessWidget {
  CardPackageInfo(
      {Key? key,
      required this.currentFunnel,
      required this.name,
      required this.details,
      required this.price,
      required this.selected})
      : super(key: key) {
    List<String> detailsList = this.details.split(",");
    detailsList.forEach((element) {
      detailsPointer.add(
        RichText(
          text: bulletText(element),
          softWrap: false,
        ),
      );
    });
  }
  final FunnelType currentFunnel;
  final String name;
  final String details;
  final String price;
  final List<Widget> detailsPointer = [];
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      width: 325,
      height: 169,
      padding: EdgeInsets.symmetric(horizontal: 16.81),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: selected ? kTextColorBlue : kAppBackgroundAltGray),
          boxShadow: [kContainerBoxShadow],
          color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        this.name,
                        style: TextStyle(
                            height: 1.5,
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                      Wrap(
                        children: detailsPointer,
                      )
                    ]),
              ),
              Container(
                height: 100,
                margin: EdgeInsets.only(bottom: 0, left: 10, right: 10),
                padding: EdgeInsets.symmetric(horizontal: 9.96),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/images/funnels/package_cost_bg.png'),
                        fit: BoxFit.fill)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Per Session',
                      style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                    Text(
                      '\u{20B9} $price',
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
          // Text.rich(TextSpan(
          //     children: detailsPointer.sublist(2, detailsPointer.length))),
          if (currentFunnel != FunnelType.PET_GROOMING)
            Column(
              children: [
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
            )
        ],
      ),
    );
  }

  TextSpan bulletText(String text) {
    return TextSpan(
      children: [
        TextSpan(text: '\u2022 ', style: TextStyle(color: kAppIconColor)),
        TextSpan(
            text: '$text  ',
            style: TextStyle(
                color: kTextColorBlue,
                fontWeight: FontWeight.w300,
                fontSize: 10,
                height: 2.7))
      ],
    );
  }
}
