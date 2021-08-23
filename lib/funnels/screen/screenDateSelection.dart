import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:the_pet_nest/config/sizeConfig.dart';
import 'package:the_pet_nest/funnels/bloc/dateTimeBloc/dateTimeBloc.dart';
import 'package:the_pet_nest/funnels/bloc/dateTimeBloc/dateTimeState.dart';
import 'package:the_pet_nest/funnels/component/cardDatePicker.dart';
import 'package:the_pet_nest/funnels/component/timeSelectionCard.dart';
import 'package:the_pet_nest/funnels/interfaces/dateTimeSelectionInterface.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/styles.dart';
import 'package:the_pet_nest/konstants/values.dart';
import 'package:the_pet_nest/utils/utils.dart';

class ScreenDateTimeSelection extends StatelessWidget {
  const ScreenDateTimeSelection(
      {Key? key, required this.onDateTimeSelected, required this.cityId})
      : super(key: key);
  final DateTimeSelectionInterface onDateTimeSelected;
  final int cityId;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DateTimeBloc>(context).setDate(DateTime.now());
    BlocProvider.of<DateTimeBloc>(context).getBookedTimeSlots();
    onDateTimeSelected.dateSelected(
        context, DateFormat('dd/MM/yyyy').format(DateTime.now()));
    return Expanded(
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 25),
                Text(
                  'Select Date',
                  style: kFunnelScreenHeadingTextStyle,
                ),
                SizedBox(
                  height: 8,
                ),
                BlocBuilder<DateTimeBloc, DateTimeState>(
                  builder: (blocContext, state) {
                    return Column(
                      children: [
                        TextButton(
                          onPressed: () {
                            BlocProvider.of<DateTimeBloc>(blocContext)
                                .showDateTimePicker();
                            showCustomDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(DateTime.now().year,
                                        DateTime.now().month + 1),
                                    cancelText: 'Close',
                                    confirmText: 'Submit')
                                .then((data) {
                              if (data != null) {
                                BlocProvider.of<DateTimeBloc>(blocContext)
                                    .setDate(data);
                                onDateTimeSelected.dateSelected(blocContext,
                                    DateFormat('dd/MM/yyyy').format(data));
                              } else {
                                BlocProvider.of<DateTimeBloc>(blocContext)
                                    .hideDateTimePicker();
                              }
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12)),
                            padding: EdgeInsets.all(15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  state.selectedDate.isNotEmpty
                                      ? state.selectedDate
                                      : 'dd/mm/yy',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      height: 1.5,
                                      color: state.selectedDate.isNotEmpty
                                          ? Colors.black87
                                          : Colors.grey),
                                ),
                                Icon(
                                  Icons.calendar_today_outlined,
                                  color: kAppIconColor,
                                )
                              ],
                            ),
                          ),
                        ),
                        Text(
                          state.selectedDate.isEmpty
                              ? 'Select Date'
                              : 'Select Time to Proceed',
                          style: TextStyle(
                              height: 1.5,
                              fontWeight: FontWeight.w400,
                              fontSize: 16),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        if (state.selectedDate.isNotEmpty)
                          state.gettingAvailableTimeSlots
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
                                          BlocProvider.of<DateTimeBloc>(
                                                  blocContext)
                                              .setTime(timeSlots[0]);
                                          onDateTimeSelected.timeSelected(
                                              blocContext,
                                              getTimeSlot(
                                                  timeSlot: timeSlots[0]));
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
                                          BlocProvider.of<DateTimeBloc>(
                                                  blocContext)
                                              .setTime(timeSlots[1]);
                                          onDateTimeSelected.timeSelected(
                                              blocContext,
                                              getTimeSlot(
                                                  timeSlot: timeSlots[1]));
                                        },
                                      ),
                                    ]),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        TimeSelectionCard(
                                          selected: state.selectedTime ==
                                              timeSlots[2],
                                          available: !state.bookedSlots!
                                              .response!.bookedSlots!
                                              .contains(timeSlots[2]),
                                          displayText: timeSlots[2],
                                          onPressed: () {
                                            BlocProvider.of<DateTimeBloc>(
                                                    blocContext)
                                                .setTime(timeSlots[2]);
                                            onDateTimeSelected.timeSelected(
                                                blocContext,
                                                getTimeSlot(
                                                    timeSlot: timeSlots[2]));
                                          },
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        TimeSelectionCard(
                                            selected: state.selectedTime ==
                                                timeSlots[3],
                                            available: !state.bookedSlots!
                                                .response!.bookedSlots!
                                                .contains(timeSlots[3]),
                                            displayText: timeSlots[3],
                                            onPressed: () {
                                              BlocProvider.of<DateTimeBloc>(
                                                      blocContext)
                                                  .setTime(timeSlots[3]);
                                              onDateTimeSelected.timeSelected(
                                                  blocContext,
                                                  getTimeSlot(
                                                      timeSlot: timeSlots[3]));
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
                                          selected: state.selectedTime ==
                                              timeSlots[4],
                                          available: !state.bookedSlots!
                                              .response!.bookedSlots!
                                              .contains(timeSlots[4]),
                                          displayText: timeSlots[4],
                                          onPressed: () {
                                            BlocProvider.of<DateTimeBloc>(
                                                    blocContext)
                                                .setTime(timeSlots[4]);
                                            onDateTimeSelected.timeSelected(
                                                blocContext,
                                                getTimeSlot(
                                                    timeSlot: timeSlots[4]));
                                          },
                                        ),
                                        SizedBox(
                                          width: SizeConfig.screenWidth / 5,
                                        ),
                                      ],
                                    )
                                  ],
                                )
                      ],
                    );
                  },
                ),
                SizedBox(
                  height: 59,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            child: TextButton(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                width: SizeConfig.blockSizeHorizontal! * 95,
                decoration: kActiveButtonContainerStyle,
                child: Text(
                  'Proceed To Payment',
                  textAlign: TextAlign.center,
                  style: kActiveButtonTextStyle,
                ),
              ),
              onPressed: () =>
                  onDateTimeSelected.onDateTimeSelectionComplete(context),
            ),
          ),
          BlocBuilder<DateTimeBloc, DateTimeState>(
              builder: (blocContext, state) {
            return Visibility(
              visible: state.showDateTimePicker,
              child: Container(
                width: SizeConfig.screenWidth!,
                height: SizeConfig.screenHeight!,
                color: Color(0x77000000),
              ),
            );
          }),
        ],
      ),
    );
  }
}
