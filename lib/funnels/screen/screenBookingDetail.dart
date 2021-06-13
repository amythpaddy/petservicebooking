import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_pet_nest/funnels/petTraining/model/petTrainingFunnelDataHolder.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/styles.dart';

class ScreenBookingDetail extends StatelessWidget {
  const ScreenBookingDetail(
      {Key? key,
      required this.screenBookingDetailResponse,
      required this.dataHolder})
      : super(key: key);
  final Function screenBookingDetailResponse;
  final PetTrainingFunnelDataHolder dataHolder;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SingleChildScrollView(
            child: Container(
                margin: EdgeInsets.all(19.36),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 24.59,
                    ),
                    Text('Booking Details',
                        style: kFunnelScreenHeadingTextStyle),
                    SizedBox(
                      height: 8.4,
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12, vertical: 14.5),
                        margin: EdgeInsets.symmetric(vertical: 8.2),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [kContainerBoxShadow]),
                        child: Row(
                          children: [
                            Image.asset('assets/images/profile/dog_avatar.png'),
                            SizedBox(
                              width: 8.84,
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Jackey',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      height: 1.5),
                                ),
                                Text(
                                  '12/05/2021',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10,
                                      height: 1.5,
                                      color: Colors.grey),
                                ),
                              ],
                            )),
                            SizedBox(
                              width: 8,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Spa Bath',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    height: 1.5,
                                  ),
                                ),
                                Text(
                                  '\u{20B9}899',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      height: 1.5,
                                      color: kAppIconColor),
                                )
                              ],
                            )
                          ],
                        )),
                    Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 22, vertical: 14.5),
                        margin: EdgeInsets.symmetric(vertical: 8.2),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [kContainerBoxShadow]),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/pet_paw_icon.svg',
                              width: 24,
                              height: 24,
                              fit: BoxFit.fill,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Add another pet',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  height: 1.5),
                            )
                          ],
                        )),
                    SizedBox(
                      height: 18.59,
                    ),
                    Text.rich(
                      TextSpan(children: [
                        TextSpan(
                          text: 'Any Preferred Pet Hero? ',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              height: 1.5),
                        ),
                        TextSpan(
                          text: ' (Optional)',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                              height: 1.5),
                        )
                      ]),
                    ),
                    SizedBox(
                      height: 8.6,
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            hintText: 'Enter name', border: InputBorder.none),
                      ),
                    )
                  ],
                )),
          ),
          Expanded(
              child: Container(
            width: double.infinity,
          )),
          Container(
            decoration: BoxDecoration(
              boxShadow: [kContainerBoxShadow],
              color: Colors.white,
            ),
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    '\u{20B9} 1800',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: kAppIconColor),
                  ),
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
                    onPressed: () => screenBookingDetailResponse(dataHolder),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration: kActiveButtonContainerStyle,
                      child: Text(
                        'Proceed to Pay',
                        style: kActiveButtonTextStyle,
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
