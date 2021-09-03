import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_pet_nest/bookings/bloc/bookingBloc.dart';
import 'package:the_pet_nest/bookings/bloc/bookingStates.dart';
import 'package:the_pet_nest/bookings/screens/screenHistoryBookings.dart';
import 'package:the_pet_nest/bookings/screens/screenOngoingBookings.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/enums.dart';
import 'package:the_pet_nest/konstants/styles.dart';

class Bookings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BookingBloc(BookingState()),
      child: Container(
          color: kAppBackgroundColor,
          child: BlocBuilder<BookingBloc, BookingState>(
            builder: (blocContext, state) {
              if (state.initialLoad) {
                BlocProvider.of<BookingBloc>(blocContext).getBookings(page: 1);
              }
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: kInactiveButtonColor,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [kContainerBoxShadow]),
                    margin:
                        EdgeInsets.symmetric(horizontal: 20.97, vertical: 13),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Container(
                                decoration:
                                    state.bookingType == BookingType.ONGOING
                                        ? kActiveButtonContainerStyle
                                        : null,
                                child: TextButton(
                                    onPressed: BlocProvider.of<BookingBloc>(
                                            blocContext)
                                        .getOngoingBookings,
                                    child: Text(
                                      'On Going',
                                      style: state.bookingType ==
                                              BookingType.ONGOING
                                          ? kActiveButtonTextStyle
                                          : kInactiveButtonTextStyle,
                                    )))),
                        Expanded(
                            child: Container(
                                decoration:
                                    state.bookingType == BookingType.HISTORY
                                        ? kActiveButtonContainerStyle
                                        : null,
                                child: TextButton(
                                    onPressed: BlocProvider.of<BookingBloc>(
                                            blocContext)
                                        .getBookingsHistory,
                                    child: Text(
                                      'History',
                                      style: state.bookingType ==
                                              BookingType.HISTORY
                                          ? kActiveButtonTextStyle
                                          : kInactiveButtonTextStyle,
                                    ))))
                      ],
                    ),
                  ),
                  state.isProcessing
                      ? Container(
                          height: 500,
                          alignment: Alignment.center,
                          child: CircularProgressIndicator())
                      : Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                state.bookingType == BookingType.ONGOING
                                    ? ScreenOngoingBookings()
                                    : ScreenBookingsHistory(),
                                SizedBox(
                                  height: 100,
                                )
                              ],
                            ),
                          ),
                        ),
                ],
              );
            },
          )),
    );
  }
}
