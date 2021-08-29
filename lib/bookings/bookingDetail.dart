import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_pet_nest/bookings/bloc/bookingBloc.dart';
import 'package:the_pet_nest/bookings/bloc/bookingStates.dart';
import 'package:the_pet_nest/bookings/model/bookingDetailArguments.dart';
import 'package:the_pet_nest/funnels/bloc/dateTimeBloc/dateTimeBloc.dart';
import 'package:the_pet_nest/funnels/bloc/dateTimeBloc/dateTimeState.dart';
import 'package:the_pet_nest/funnels/interfaces/BookingConfirmationInterface.dart';
import 'package:the_pet_nest/funnels/screen/screenBookingConfirmation.dart';
import 'package:the_pet_nest/konstants/colors.dart';

class BookingDetail extends StatelessWidget
    implements BookingConfirmationInterface {
  const BookingDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as BookingDetailArguments;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: kAppBackgroundColor,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: Text(
            'Booking Details',
            style: TextStyle(color: kAppIconColor),
          ),
        ),
        body: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => BookingBloc(BookingState())),
            BlocProvider(create: (_) => DateTimeBloc(DateTimeState()))
          ],
          child: BlocBuilder<BookingBloc, BookingState>(
            builder: (blocContext, state) {
              if (state.initialLoad)
                BlocProvider.of<BookingBloc>(blocContext)
                    .getBookingDetails(args.leadId);
              return state.isProcessing
                  ? CircularProgressIndicator()
                  : ScreenBookingConfirmation(onBookingConfirmation: this);
            },
          ),
        ),
      ),
    );
  }

  @override
  void onCancelBooking(blocContext) {
    // TODO: implement onCancelBooking
  }

  @override
  void onMakeCall(blocContext, String phoneNumber) {
    // TODO: implement onMakeCall
  }

  @override
  void onReschedule(blocContext) {
    // TODO: implement onReschedule
  }
}
