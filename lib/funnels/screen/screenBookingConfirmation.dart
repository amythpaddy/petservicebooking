import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:the_pet_nest/bookings/bloc/bookingBloc.dart';
import 'package:the_pet_nest/bookings/bloc/bookingStates.dart';
import 'package:the_pet_nest/funnels/component/bookingConfirmationDataComponent.dart';
import 'package:the_pet_nest/funnels/component/bookingStatusHeaderIcons.dart';
import 'package:the_pet_nest/funnels/component/customDateTimeSelectorComponent.dart';
import 'package:the_pet_nest/funnels/interfaces/BookingConfirmationInterface.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/styles.dart';
import 'package:the_pet_nest/utils/utils.dart';

class ScreenBookingConfirmation extends StatelessWidget {
  final BookingConfirmationInterface onBookingConfirmation;

  const ScreenBookingConfirmation(
      {Key? key, required this.onBookingConfirmation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
              child: BlocBuilder<BookingBloc, BookingState>(
            builder: (blocContext, state) {
              return state.isProcessing
                  ? CircularProgressIndicator(
                      color: kAppIconColor,
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BookingHeaderIcons(
                                title: "Details",
                                icon:
                                    "assets/images/funnels/icon_booking_detail.svg"),
                            BookingHeaderIcons(
                              title: "Reschedule",
                              icon:
                                  "assets/images/funnels/icon_booking_reschedule.svg",
                              onPressed: () {
                                BlocProvider.of<BookingBloc>(context)
                                    .showDateTimePicker();
                              },
                            ),
                            BookingHeaderIcons(
                                title: "Cancel",
                                icon:
                                    "assets/images/funnels/icon_booking_cancel.svg"),
                            BookingHeaderIcons(
                                title: "Done",
                                icon:
                                    "assets/images/funnels/icon_booking_done.svg"),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.all(13),
                          decoration: kDataContainerStyle,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                      'assets/images/funnels/icon_booking_congratulation.svg'),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Congratulation!',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18,
                                              height: 1.5),
                                        ),
                                        Text(
                                          'Your pet grooming appointment is successfully booked.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              height: 1.5),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Divider(),
                              BookingConfirmationDataComponent(
                                  title: 'Booking Id:',
                                  value:
                                      '${state.bookingData!.lead!.orderUuid!.toUpperCase()}'),
                              BookingConfirmationDataComponent(
                                  title: 'Time Slot:',
                                  value: DateFormat("hh:mm a").format(
                                      DateTime.parse(state.bookingData!.lead!
                                          .appointmentDatetime!))),
                              BookingConfirmationDataComponent(
                                  title: 'Appointment Date:',
                                  value: DateFormat("dd/MM/yyyy").format(
                                      DateTime.parse(state.bookingData!.lead!
                                          .appointmentDatetime!)))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Visibility(
                            visible: state.bookingData!.lead!.petHero == null,
                            child: Container(
                              padding: EdgeInsets.all(7),
                              decoration: kDataContainerStyle,
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                      'assets/images/funnels/icon_okay_bg_faded.svg'),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                        'A professional groomer will be assigned 30 minutes before your appointment.'),
                                  )
                                ],
                              ),
                            )),
                        Visibility(
                            visible: state.bookingData!.lead!.petHero != null,
                            child: Container(
                              decoration: kDataContainerStyle,
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(15),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          child: Text('PH'),
                                          backgroundColor: Colors.red.shade500,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "Pet Hero",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  height: 1.5,
                                                  color: kAppIconColor,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 18, vertical: 15),
                            decoration: kDataContainerStyle,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/images/home/refer_n_earn.svg',
                                  height: 36,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Refer and Earn',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          height: 1.5),
                                    ),
                                    Text(
                                      'Guaranteed reward for every referral',
                                      style: TextStyle(
                                          fontSize: 12,
                                          height: 1.5,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFFB6B7B9)),
                                    )
                                  ],
                                )
                              ],
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: kDataContainerStyle,
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Payment Summary',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              height: 1.5),
                                        ),
                                        Text(
                                          '  Package',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              height: 1.5,
                                              color: Color(0xAA1A202E)),
                                        ),
                                        Container(
                                          height: 25,
                                          margin: EdgeInsets.only(left: 6),
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: state
                                                  .bookingData!
                                                  .lead!
                                                  .leadPetPackages!
                                                  .length,
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                return Text(
                                                  index ==
                                                          state
                                                                  .bookingData!
                                                                  .lead!
                                                                  .leadPetPackages!
                                                                  .length -
                                                              1
                                                      ? state
                                                          .bookingData!
                                                          .lead!
                                                          .leadPetPackages![
                                                              index]
                                                          .package!
                                                          .groomerPackage!
                                                          .name!
                                                      : '${state.bookingData!.lead!.leadPetPackages![index].package!.groomerPackage!.name!}, ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 12,
                                                      height: 1.5,
                                                      color: Color(0x771A202E)),
                                                );
                                              }),
                                        )
                                      ],
                                    ),
                                  ),
                                  //todo: populate this value based on response from the api
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.green),
                                        borderRadius: BorderRadius.circular(5)),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    child: Text(
                                      "Successful",
                                      style: TextStyle(
                                          height: 1.5,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.green),
                                    ),
                                  )
                                ],
                              ),
                              Divider(),
                              //todo: update this amount from the api response
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Amount Pay',
                                    style: TextStyle(
                                        fontSize: 14,
                                        height: 1.5,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    '\u{20B9} 800',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                        height: 1.5,
                                        color: kAppIconColor),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            decoration: kDataContainerStyle,
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                    'assets/images/funnels/icon_payment_online.svg'),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Pay Online',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      height: 1.5),
                                )
                              ],
                            ))
                      ],
                    );
            },
          )),
        ),
        BlocBuilder<BookingBloc, BookingState>(builder: (blocContext, state) {
          return Visibility(
              visible: state.showDateTimePicker,
              child: CustomDateTimeSelectorComponent(
                showTimeSlots: true,
                onConfirm: (String selectedDate, String selectedTime) {
                  BlocProvider.of<BookingBloc>(blocContext).reschedule(
                      state.bookingData!.lead!.id.toString(),
                      selectedDate,
                      getTimeSlot(timeSlot: selectedTime));
                },
              ));
        })
      ],
    );
  }
}
