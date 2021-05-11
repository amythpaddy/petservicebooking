import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/styles.dart';

class OngoingBookingCard extends StatelessWidget {
  final String serviceName;
  final String petName;
  final String petHero;
  final String dateTime;
  final String orderId;
  final String petHeroRating;

  const OngoingBookingCard(
      {Key key,
      this.serviceName,
      this.petName,
      this.petHero,
      this.dateTime,
      this.orderId,
      this.petHeroRating})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5.84),
      decoration: BoxDecoration(
        boxShadow: [kContainerBoxShadow],
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      serviceName,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          height: 1.5),
                    ),

                    Text('Order id: $orderId',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                            height: 1.5,
                            color: Color(0xFF0C0F15)))
                  ],
                ),
                Text(
                  dateTime,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 12, height: 1.5),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 8.25),
            height: 1.5,
            color: Color.fromARGB(16, 00, 0, 0),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset('assets/images/bookings/dog_placeholder.svg'),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      petName,
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16, height: 1.5),
                    ),
                    Text.rich(TextSpan(
                        children: [
                      TextSpan(
                          text: 'Pet Hero:',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              height: 1.5)),
                      TextSpan(
                          text: petHero,
                          style: TextStyle(
                              color: kAppIconColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              height: 1.5))
                    ])),
                    Text.rich(TextSpan(children: [
                      WidgetSpan(
                          child: Icon(
                            Icons.star,
                            color: kAppIconColor,
                          )),
                      TextSpan(
                          text: petHeroRating,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              height: 1.5)),
                    ])),
                  ],
                ),
                Expanded(child: SizedBox(height: 1,)),
                Container(
                  child: Text(
                    'On Going',
                    style: TextStyle(
                        color: kAppIconColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        height: 1.5),
                  ),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(40, 255, 119, 23),
                      boxShadow: [kContainerBoxShadow],
                      borderRadius: BorderRadius.circular(6)),
                  padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 3.75),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
