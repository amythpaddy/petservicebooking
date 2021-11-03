import 'package:flutter/material.dart';
import 'package:the_pet_nest/config/sizeConfig.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/styles.dart';

class BottomPriceDisplayComponent extends StatelessWidget {
  const BottomPriceDisplayComponent(
      {Key? key,
      required this.totalPrice,
      this.discountPrice = 0,
      required this.onPressed,
      required this.proceedText})
      : super(key: key);
  final double totalPrice;
  final double discountPrice;
  final void Function()? onPressed;
  final String proceedText;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
          boxShadow: [kContainerBoxShadow],
          color: Colors.white,
        ),
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 13),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: '\u{20B9} ${(totalPrice - discountPrice).toInt()}',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      height: 1.5,
                      color: kAppIconColor),
                ),
                TextSpan(
                  text: discountPrice > 0 ? "-${discountPrice.toInt()}" : "",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      height: 1.5,
                      color: kTextColorBlue),
                )
              ])),
              Text(
                'View Details',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    height: 1.5,
                    color: kTextColorBlue),
              )
            ]),
            TextButton(
                onPressed: onPressed,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  decoration: kActiveButtonContainerStyle,
                  child: Text(
                    proceedText,
                    style: kActiveButtonTextStyle,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
