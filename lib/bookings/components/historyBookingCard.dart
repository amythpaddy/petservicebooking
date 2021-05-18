import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_pet_nest/bookings/model/feedbackDataHolder.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/paths.dart';
import 'package:the_pet_nest/konstants/styles.dart';

class HistoryBookingCard extends StatelessWidget {
  final String serviceName;
  final String petName;
  final String petHero;
  final String dateTime;
  final String orderId;
  final String petHeroRating;
  final bool cancelled;

  const HistoryBookingCard(
      {Key key,
      this.serviceName,
      this.petName,
      this.petHero,
      this.dateTime,
      this.orderId,
      this.petHeroRating,
      this.cancelled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Text(
                        serviceName,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            height: 1.5),
                      ),
                    ),
                    SizedBox(width: 2),
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
                Image.asset('assets/images/profile/dog_avatar.png'),
                SizedBox(
                  width: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      petName,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          height: 1.5),
                    ),
                    Text.rich(TextSpan(children: [
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
                            color: Colors.amber,
                            size: 14,
                          ),
                          alignment: PlaceholderAlignment.middle),
                      TextSpan(
                          text: petHeroRating,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              height: 1.5)),
                    ])),
                  ],
                ),
                Expanded(
                    child: SizedBox(
                  height: 1.5,
                )),
                Container(
                  child: Text(
                    cancelled ? 'Cancelled' : 'Completed',
                    style: TextStyle(
                        color:
                            cancelled ? Color(0xFFFF5B5B) : Color(0xFF00BE63),
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        height: 1.5),
                  ),
                  decoration: BoxDecoration(
                      color: cancelled
                          ? Color.fromARGB(40, 255, 91, 91)
                          : Color.fromARGB(40, 0, 190, 99),
                      boxShadow: [kContainerBoxShadow],
                      borderRadius: BorderRadius.circular(6)),
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.75),
                )
              ],
            ),
          ),
          cancelled
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 39, vertical: 9),
                            decoration: BoxDecoration(
                                border: Border.all(color: kAppIconColor),
                                borderRadius: BorderRadius.circular(6),
                                boxShadow: [kContainerBoxShadow]),
                            child: Text('View Booking',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    height: 1.5,
                                    color: kAppIconColor))))
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 39, vertical: 9),
                            decoration: BoxDecoration(
                                border: Border.all(color: kAppIconColor),
                                borderRadius: BorderRadius.circular(6),
                                boxShadow: [kContainerBoxShadow]),
                            child: Text('Support',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    height: 1.5,
                                    color: kAppIconColor)))),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, kNavigationFeedback,
                              arguments: FeedbackDataHolder(petHero, 'Delhi'));
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 39, vertical: 9),
                          decoration: BoxDecoration(
                              color: kAppIconColor,
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [kContainerBoxShadow]),
                          child: Text(
                            'Feedback',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                height: 1.5,
                                color: Colors.white),
                          ),
                        )),
                  ],
                ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
