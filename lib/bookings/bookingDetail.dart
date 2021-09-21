import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_pet_nest/bookings/bloc/bookingBloc.dart';
import 'package:the_pet_nest/bookings/bloc/bookingStates.dart';
import 'package:the_pet_nest/bookings/model/bookingDetailArguments.dart';
import 'package:the_pet_nest/funnels/bloc/dateTimeBloc/dateTimeBloc.dart';
import 'package:the_pet_nest/funnels/bloc/dateTimeBloc/dateTimeState.dart';
import 'package:the_pet_nest/funnels/interfaces/BookingConfirmationInterface.dart';
import 'package:the_pet_nest/funnels/model/bookingConfirmationResponseModel.dart';
import 'package:the_pet_nest/funnels/screen/sceenPayment.dart';
import 'package:the_pet_nest/funnels/screen/screenBookingCancelled.dart';
import 'package:the_pet_nest/funnels/screen/screenBookingConfirmation.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/enums.dart';

class BookingDetail extends StatelessWidget
    implements BookingConfirmationInterface {
  const BookingDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as BookingDetailArguments;
    return Scaffold(
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
        centerTitle: true,
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => BookingBloc(BookingState())),
          BlocProvider(create: (_) => DateTimeBloc(DateTimeState()))
        ],
        child: BlocBuilder<BookingBloc, BookingState>(
          builder: (blocContext, state) {
            print(state.bookingCancelled);
            if (state.initialLoad)
              BlocProvider.of<BookingBloc>(blocContext)
                  .getBookingDetails(args.leadId);
            return state.isProcessing
                ? Center(
                    child: CircularProgressIndicator(
                    color: kAppIconColor,
                  ))
                : state.bookingCancelled || !args.onGoing
                    ? ScreenBookingCancelled()
                    : ScreenBookingConfirmation(
                        onBookingConfirmation: this,
                        currentFunnel: getCurrentFunnel(
                            state.bookingData!.lead!.leadType!),
                      );
          },
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

  FunnelType getCurrentFunnel(String leadType) {
    if (leadType == 'grooming') {
      return FunnelType.PET_GROOMING;
    } else if (leadType == 'training') {
      return FunnelType.PET_TRAINING;
    } else
      return FunnelType.VET_SERVICE;
  }

  @override
  void payOnline(
      blocContext, BookingConfirmationData bookingConfirmationData) async {
    bool result = await Navigator.of(blocContext).push(MaterialPageRoute(
            builder: (context) => PaymentScreen(
                bookingConfirmationData: bookingConfirmationData))) ??
        false;
    if (result)
      BlocProvider.of<BookingBloc>(blocContext)
          .getBookingDetails(bookingConfirmationData.lead!.id!);
  }
}
