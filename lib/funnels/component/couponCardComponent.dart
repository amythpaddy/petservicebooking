import 'package:flutter/material.dart';
import 'package:the_pet_nest/konstants/styles.dart';

class CouponCard extends StatelessWidget {
  const CouponCard({
    Key? key,
    required this.discountValue,
    required this.discountDescription,
    required this.discountCode,
    required this.onPressed,
  }) : super(key: key);

  final double discountValue;
  final String discountDescription;
  final String discountCode;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(boxShadow: [kContainerBoxShadow]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 102,
            height: 102,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/images/funnels/bg_image_coupon.png"),
            )),
            child: Center(
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: '\u{20B9}${discountValue.toInt()}',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 28,
                        height: 1.5)),
                WidgetSpan(
                  child: Transform.translate(
                    offset: const Offset(2, -20),
                    child: Text(
                      'Off',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 10,
                          height: 1.5),
                    ),
                  ),
                )
              ])),
            ),
          ),
          Expanded(
            child: Container(
              height: 102,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(discountDescription,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        height: 1.5,
                      )),
                  Wrap(
                    direction: Axis.horizontal,
                    runAlignment: WrapAlignment.end,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
                        onPressed: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 3.5, horizontal: 10),
                          decoration: BoxDecoration(
                              color: Color(0x33FF7717),
                              borderRadius: BorderRadius.circular(31)),
                          child: Text(discountCode),
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
                        onPressed: onPressed,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 3.5, horizontal: 10),
                          decoration: BoxDecoration(
                              color: Color(0xFFFF7717),
                              borderRadius: BorderRadius.circular(31)),
                          child: Text(
                            'COPY',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
