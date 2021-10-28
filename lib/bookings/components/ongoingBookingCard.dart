import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:the_pet_nest/bookings/model/bookingDataModel.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/styles.dart';

class OngoingBookingCard extends StatelessWidget {
  final String serviceName;
  final String petName;
  final PetHero? petHero;
  final String dateTime;
  final String leadUUID;
  final bool ongoing;
  final int petCategory;

  const OngoingBookingCard(
      {Key? key,
      required this.serviceName,
      required this.petName,
      required this.petHero,
      required this.dateTime,
      required this.leadUUID,
      required this.ongoing,
      required this.petCategory})
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Pet ${toBeginningOfSentenceCase(serviceName)}  Service',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          height: 1.5,
                          color: Colors.black),
                    ),
                    Text('Booking id: $leadUUID',
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
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      height: 1.5,
                      color: Color(0x99151724)),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 2.25, bottom: 8.25),
            height: 1.5,
            color: Color.fromARGB(16, 00, 0, 0),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  petCategory == 2
                      ? 'assets/images/dog_avatar.svg'
                      : 'assets/images/cat_avatar.svg',
                  height: 60,
                  width: 60,
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        petName,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            height: 1.5,
                            color: Colors.black),
                      ),
                      if (petHero != null)
                        Text.rich(TextSpan(children: [
                          TextSpan(
                              text: 'Pet Hero:',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  height: 1.5,
                                  color: Colors.black)),
                          TextSpan(
                              text: petHero!.name,
                              style: TextStyle(
                                color: kAppIconColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                height: 1.5,
                              ))
                        ])),
                      petHero != null
                          ? Text.rich(TextSpan(children: [
                              WidgetSpan(
                                  child: Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 14,
                                  ),
                                  alignment: PlaceholderAlignment.middle),
                              TextSpan(
                                  text: petHero!.rating,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      height: 1.5,
                                      color: Colors.black)),
                            ]))
                          : Text(
                              'A pet hero will be assigned to you soon',
                            ),
                    ],
                  ),
                ),
                Container(
                  child: Text(
                    ongoing ? 'On Going' : "Scheduled",
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.75),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
