import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_pet_nest/bookings/bloc/bookingBloc.dart';
import 'package:the_pet_nest/config/sizeConfig.dart';
import 'package:the_pet_nest/funnels/bloc/dateTimeBloc/dateTimeBloc.dart';
import 'package:the_pet_nest/funnels/bloc/dateTimeBloc/dateTimeState.dart';
import 'package:the_pet_nest/funnels/component/timeSelectionCard.dart';
import 'package:the_pet_nest/konstants/styles.dart';
import 'package:the_pet_nest/konstants/values.dart';

class CustomDateTimeSelectorComponent extends StatelessWidget {
  const CustomDateTimeSelectorComponent(
      {Key? key,
      this.showTimeSlots = false,
      required this.onConfirm,
      required this.leadType})
      : super(key: key);
  final bool showTimeSlots;
  final void Function(String, String) onConfirm;
  final String leadType;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Color(0x55000000),
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight - 110,
        ),
        BlocBuilder<DateTimeBloc, DateTimeState>(
          builder: (blocContext, state) {
            if (state.bookedSlots!.response == null &&
                showTimeSlots &&
                state.gettingAvailableTimeSlots) {
              BlocProvider.of<DateTimeBloc>(blocContext).setDate(DateTime.now(),
                  format: "dd-MM-yyyy", leadType: leadType);
            }
            return Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              decoration: kDataContainerStyle,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CalendarDatePicker(
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(
                          DateTime.now().year + 1, DateTime.now().month),
                      onDateChanged: (date) {
                        BlocProvider.of<DateTimeBloc>(blocContext).setDate(date,
                            format: "dd-MM-yyyy", leadType: leadType);
                      }),
                  Visibility(
                      visible: showTimeSlots,
                      child: state.gettingAvailableTimeSlots
                          ? CircularProgressIndicator()
                          : Column(
                              children: [
                                Row(children: [
                                  TimeSelectionCard(
                                    selected:
                                        state.selectedTime == timeSlots[0],
                                    available: !state
                                        .bookedSlots!.response!.bookedSlots!
                                        .contains(timeSlots[0]),
                                    displayText: timeSlots[0],
                                    onPressed: () {
                                      BlocProvider.of<DateTimeBloc>(blocContext)
                                          .setTime(timeSlots[0]);
                                    },
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  TimeSelectionCard(
                                    selected:
                                        state.selectedTime == timeSlots[1],
                                    available: !state
                                        .bookedSlots!.response!.bookedSlots!
                                        .contains(timeSlots[1]),
                                    displayText: timeSlots[1],
                                    onPressed: () {
                                      BlocProvider.of<DateTimeBloc>(blocContext)
                                          .setTime(timeSlots[1]);
                                    },
                                  ),
                                ]),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    TimeSelectionCard(
                                      selected:
                                          state.selectedTime == timeSlots[2],
                                      available: !state
                                          .bookedSlots!.response!.bookedSlots!
                                          .contains(timeSlots[2]),
                                      displayText: timeSlots[2],
                                      onPressed: () {
                                        BlocProvider.of<DateTimeBloc>(
                                                blocContext)
                                            .setTime(timeSlots[2]);
                                      },
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    TimeSelectionCard(
                                        selected:
                                            state.selectedTime == timeSlots[3],
                                        available: !state
                                            .bookedSlots!.response!.bookedSlots!
                                            .contains(timeSlots[3]),
                                        displayText: timeSlots[3],
                                        onPressed: () {
                                          BlocProvider.of<DateTimeBloc>(
                                                  blocContext)
                                              .setTime(timeSlots[3]);
                                        }),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: SizeConfig.screenWidth / 5,
                                    ),
                                    TimeSelectionCard(
                                      selected:
                                          state.selectedTime == timeSlots[4],
                                      available: !state
                                          .bookedSlots!.response!.bookedSlots!
                                          .contains(timeSlots[4]),
                                      displayText: timeSlots[4],
                                      onPressed: () {
                                        BlocProvider.of<DateTimeBloc>(
                                                blocContext)
                                            .setTime(timeSlots[4]);
                                      },
                                    ),
                                    SizedBox(
                                      width: SizeConfig.screenWidth / 5,
                                    ),
                                  ],
                                )
                              ],
                            )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          BlocProvider.of<BookingBloc>(blocContext)
                              .hideDatePicker();
                        },
                        child: Container(
                            width: 106,
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10),
                            decoration: kActiveButtonContainerBlueStyle,
                            child: Text(
                              'Close',
                              style: kActiveButtonTextStyle,
                            )),
                      ),
                      TextButton(
                        onPressed: () =>
                            onConfirm(state.selectedDate, state.selectedTime),
                        child: Container(
                            width: 106,
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(8),
                            decoration: kActiveButtonContainerStyle,
                            child: Text(
                              'Submit',
                              style: kActiveButtonTextStyle,
                            )),
                      )
                    ],
                  )
                ],
              ),
            );
          },
        )
      ],
    );
  }
}
