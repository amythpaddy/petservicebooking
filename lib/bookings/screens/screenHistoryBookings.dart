import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:the_pet_nest/bookings/bloc/bookingBloc.dart';
import 'package:the_pet_nest/bookings/bloc/bookingStates.dart';
import 'package:the_pet_nest/bookings/components/historyBookingCard.dart';
import 'package:the_pet_nest/bookings/components/noRecentBooking.dart';
import 'package:the_pet_nest/bookings/model/bookingDataModel.dart';
import 'package:the_pet_nest/bookings/model/bookingDetailArguments.dart';
import 'package:the_pet_nest/konstants/paths.dart';

class ScreenBookingsHistory extends StatelessWidget {
  const ScreenBookingsHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingBloc, BookingState>(
        builder: (blocContext, state) {
      List<BookingData> historyBookings = state.bookingsList!.data!
          .where((element) =>
              !(element.status == "new" || element.status == "in_progress"))
          .toList();

      return historyBookings.length == 0
          ? NoDataAvailableComponent(
              mainText: 'No Recent Bookings',
              subText:
                  'Book an appointment and your booking\nDetails will show up here',
            )
          : ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: historyBookings.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return TextButton(
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.all(0),
                      textStyle: TextStyle(color: Colors.black)),
                  onPressed: () {
                    BookingDetailArguments args = BookingDetailArguments(
                        leadId: historyBookings[index].id!,
                        onGoing: false,
                        leadType: historyBookings[index].leadType!);
                    Navigator.pushNamed(
                            blocContext, kNavigationBookingDetailsPage,
                            arguments: args)
                        .then((value) =>
                            BlocProvider.of<BookingBloc>(blocContext)
                                .getBookings(page: 1));
                  },
                  child: HistoryBookingCard(
                    petName: historyBookings[index].leadPetPackages!.length > 0
                        ? historyBookings[index]
                            .leadPetPackages![0]
                            .customerPet!
                            .name!
                        : '',
                    leadUUID: historyBookings[index].leadUuid!,
                    dateTime: historyBookings[index].appointmentDatetime != null
                        ? DateFormat("EEEE, dd MMM,yy - hh:mm a").format(
                            DateTime.parse(
                                historyBookings[index].appointmentDatetime!))
                        : '',
                    serviceName: historyBookings[index].leadType ?? '',
                    petHero: historyBookings[index].petHero,
                    cancelled: historyBookings[index].status == 'cancelled',
                    city: '', //todo: city name to be fetched,
                    leadId: historyBookings[index].id!,
                    leadType: historyBookings[index].leadType!,
                    petCategory:
                        historyBookings[index].leadPetPackages!.length > 0
                            ? historyBookings[index]
                                .leadPetPackages![0]
                                .customerPet!
                                .categoryId!
                            : 2,
                  ),
                );
              },
            );
    });
  }
}
