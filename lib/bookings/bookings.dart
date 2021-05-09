import 'package:flutter/material.dart';
import 'package:the_pet_nest/bookings/components/historyBookingCard.dart';
import 'package:the_pet_nest/bookings/components/noRecentBooking.dart';
import 'package:the_pet_nest/bookings/components/ongoingBookingCard.dart';
import 'package:the_pet_nest/bookings/model/bookingsDetails.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/styles.dart';

enum BookingType { HISTORY, ONGOING }

class Bookings extends StatefulWidget {
  @override
  _BookingsState createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {
  _BookingsState() {
    Future.delayed(Duration(milliseconds: 3500), () {
      setState(() {
        _loading = false;
      });
    });
  }

  BookingType _bookingType = BookingType.ONGOING;
  bool _loading = true;

  void getOnGoingBookingData() {
    if (_bookingType != BookingType.ONGOING) {
      setState(() {
        _bookingType = BookingType.ONGOING;
      });
    }
  }

  void getHistoryBookingData() {
    if (_bookingType != BookingType.HISTORY) {
      setState(() {
        _bookingType = BookingType.HISTORY;
      });
    }
  }

  Widget getOnGoingBookingUI() {
    if (onGoingBookings.length == 0)
      return NoRecentBookings(
        mainText: 'No Recent Bookings',
        subText:
            'Book an appointment and your booking\nDetails will show up here',
      );
    else
      return (ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: onGoingBookings.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return OngoingBookingCard(
            petName: onGoingBookings[index]["petName"],
            orderId: onGoingBookings[index]["orderId"],
            dateTime: onGoingBookings[index]["dateTime"],
            serviceName: onGoingBookings[index]["serviceName"],
            petHero: onGoingBookings[index]["petHero"],
            petHeroRating: onGoingBookings[index]["petHeroRating"],
          );
        },
      ));
  }

  Widget getHistoryBookingUI() {
    if (historyBookings.length == 0)
      return NoRecentBookings(
        mainText: 'No Recent History',
      );
    else
      return (ListView.builder(
        scrollDirection: Axis.vertical,
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: historyBookings.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return HistoryBookingCard(
            petName: historyBookings[index]["petName"],
            orderId: historyBookings[index]["orderId"],
            dateTime: historyBookings[index]["dateTime"],
            serviceName: historyBookings[index]["serviceName"],
            petHero: historyBookings[index]["petHero"],
            petHeroRating: historyBookings[index]["petHeroRating"],
            cancelled: historyBookings[index]["cancelled"],
          );
        },
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kAppBackgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            decoration: BoxDecoration(
                color: kInactiveButtonColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [kContainerBoxShadow]),
            margin: EdgeInsets.symmetric(horizontal: 20.97, vertical: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Container(
                        decoration: _bookingType == BookingType.ONGOING
                            ? kActiveButtonContainerStyle
                            : null,
                        child: TextButton(
                            onPressed: getOnGoingBookingData,
                            child: Text(
                              'On Going',
                              style: _bookingType == BookingType.ONGOING
                                  ? kActiveButtonTextStyle
                                  : kInactiveButtonTextStyle,
                            )))),
                Expanded(
                    child: Container(
                        decoration: _bookingType == BookingType.HISTORY
                            ? kActiveButtonContainerStyle
                            : null,
                        child: TextButton(
                            onPressed: getHistoryBookingData,
                            child: Text(
                              'History',
                              style: _bookingType == BookingType.HISTORY
                                  ? kActiveButtonTextStyle
                                  : kInactiveButtonTextStyle,
                            ))))
              ],
            ),
          ),
          if (_loading)
            Container(
                height: 500,
                alignment: Alignment.center,
                child: CircularProgressIndicator())
          else
            SingleChildScrollView(
              child: Column(
                children: [
                  _bookingType == BookingType.ONGOING
                      ? getOnGoingBookingUI()
                      : getHistoryBookingUI(),
                  SizedBox(height: 150,)
                ],
              ),
            ),
        ],
      ),
    );
  }
}
