import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:the_pet_nest/bookings/bloc/bookingBloc.dart';
import 'package:the_pet_nest/bookings/bloc/bookingStates.dart';
import 'package:the_pet_nest/bookings/components/noRecentBooking.dart';
import 'package:the_pet_nest/bookings/components/ongoingBookingCard.dart';
import 'package:the_pet_nest/bookings/model/bookingDataModel.dart';
import 'package:the_pet_nest/bookings/model/bookingDetailArguments.dart';
import 'package:the_pet_nest/konstants/paths.dart';

class ScreenOngoingBookings extends StatelessWidget {
  ScreenOngoingBookings({Key? key}) : super(key: key);
  final ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingBloc, BookingState>(
        builder: (blocContext, state) {
      // _controller.addListener(() {
      //   print(
      //       '${_controller.position.pixels}---${_controller.position.maxScrollExtent - 50}--${state.bookingsList!.meta!.currentCount!}------${state.bookingsList!.meta!.totalCount!}');
      //   if ((_controller.position.pixels >
      //           _controller.position.maxScrollExtent - 50) &&
      //       (state.bookingsList!.meta!.currentCount! <
      //           state.bookingsList!.meta!.totalCount!)) {
      //     BlocProvider.of<BookingBloc>(context)
      //         .getBookings(page: state.currentPage + 1);
      //   }
      // });
      List<BookingData> onGoingBookings = state.bookingsList!.data!
          .where((element) =>
              element.status == "new" || element.status == "in_progress")
          .toList();

      return onGoingBookings.length == 0
          ? NoDataAvailableComponent(
              mainText: 'No Recent Bookings',
              subText:
                  'Book an appointment and your booking\nDetails will show up here',
            )
          : ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: onGoingBookings.length,
              shrinkWrap: true,
              controller: _controller,
              itemBuilder: (context, index) {
                return TextButton(
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.all(0),
                      textStyle: TextStyle(color: Colors.black)),
                  onPressed: () {
                    BookingDetailArguments args = BookingDetailArguments(
                        leadId: onGoingBookings[index].id!, onGoing: true);
                    Navigator.pushNamed(
                            blocContext, kNavigationBookingDetailsPage,
                            arguments: args)
                        .then((value) =>
                            BlocProvider.of<BookingBloc>(blocContext)
                                .getBookings(page: 1));
                  },
                  child: OngoingBookingCard(
                      petName: onGoingBookings[index]
                          .leadPetPackages![0]
                          .customerPet!
                          .name!,
                      leadUUID: onGoingBookings[index].leadUuid!,
                      dateTime: DateFormat("EEEE, dd MMM,yy - hh:mm a").format(
                          DateTime.parse(
                              onGoingBookings[index].appointmentDatetime!)),
                      serviceName: onGoingBookings[index].leadType!,
                      petHero: onGoingBookings[index].petHero,
                      ongoing: onGoingBookings[index].status == "in_progress"),
                );
              },
            );
    });
  }
}
