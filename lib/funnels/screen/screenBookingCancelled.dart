import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:the_pet_nest/bookings/bloc/bookingBloc.dart';
import 'package:the_pet_nest/bookings/bloc/bookingStates.dart';
import 'package:the_pet_nest/funnels/component/bookingConfirmationDataComponent.dart';
import 'package:the_pet_nest/funnels/component/bookingStatusHeaderIcons.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/styles.dart';

class ScreenBookingCancelled extends StatelessWidget {
  const ScreenBookingCancelled({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child:
          SingleChildScrollView(child: BlocBuilder<BookingBloc, BookingState>(
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
                        Expanded(
                          child: BookingHeaderIcons(
                            title: "Details",
                            icon:
                                "assets/images/funnels/icon_booking_detail.svg",
                            iconColor: kAppIconColor,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: BookingHeaderIcons(
                            title: "Reschedule",
                            icon:
                                "assets/images/funnels/icon_booking_reschedule.svg",
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: BookingHeaderIcons(
                            title: "Cancel",
                            icon:
                                "assets/images/funnels/icon_booking_cancel.svg",
                            iconColor: kAppIconColor,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: BookingHeaderIcons(
                            title: "Done",
                            icon: "assets/images/funnels/icon_booking_done.svg",
                          ),
                        ),
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
                          Text(
                            'Booking Details',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
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
                    Container(
                      decoration: kDataContainerStyle,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                          itemCount: state.bookingData!.lead!
                                              .leadPetPackages!.length,
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
                                                      .leadPetPackages![index]
                                                      .package!
                                                      .groomerPackage!
                                                      .name!
                                                  : '${state.bookingData!.lead!.leadPetPackages![index].package!.groomerPackage!.name!}, ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
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
                                    border: Border.all(color: Colors.redAccent),
                                    borderRadius: BorderRadius.circular(5)),
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  "Cancelled",
                                  style: TextStyle(
                                      height: 1.5,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.redAccent),
                                ),
                              )
                            ],
                          ),
                          Divider(),
                          //todo: update this amount from the api response
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  ],
                );
        },
      )),
    );
  }
}
