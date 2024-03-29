import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:the_pet_nest/bookings/bloc/bookingBloc.dart';
import 'package:the_pet_nest/bookings/bloc/bookingStates.dart';
import 'package:the_pet_nest/config/sizeConfig.dart';
import 'package:the_pet_nest/funnels/component/bookingConfirmationDataComponent.dart';
import 'package:the_pet_nest/funnels/component/bookingStatusHeaderIcons.dart';
import 'package:the_pet_nest/funnels/component/customDateTimeSelectorComponent.dart';
import 'package:the_pet_nest/funnels/interfaces/BookingConfirmationInterface.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/enums.dart';
import 'package:the_pet_nest/konstants/paths.dart';
import 'package:the_pet_nest/konstants/styles.dart';
import 'package:the_pet_nest/konstants/values.dart';
import 'package:the_pet_nest/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class ScreenBookingConfirmation extends StatelessWidget {
  final BookingConfirmationInterface onBookingConfirmation;
  final FunnelType currentFunnel;
  final bool fromFunnels;

  const ScreenBookingConfirmation(
      {Key? key,
      required this.onBookingConfirmation,
      required this.currentFunnel,
      this.fromFunnels = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String leadType = '';
    switch (currentFunnel) {
      case FunnelType.VET_SERVICE:
        leadType = kLeadTypeVet;
        break;
      case FunnelType.PET_GROOMING:
        leadType = kLeadTypeGrooming;
        break;
      default:
        leadType = kLeadTypeTraining;
        break;
    }
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
              child: BlocListener<BookingBloc, BookingState>(
            listener: (listenerContext, state) {
              if (state.bookingCancelled)
                onBookingConfirmation.onCancelBooking(listenerContext);
            },
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Visibility(
                                visible: currentFunnel == FunnelType.VET_SERVICE
                                    ? false
                                    : true,
                                child: BookingHeaderIcons(
                                  title: "Details",
                                  icon:
                                      "assets/images/funnels/icon_booking_detail.svg",
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Visibility(
                                visible: currentFunnel == FunnelType.VET_SERVICE
                                    ? false
                                    : true,
                                child: BookingHeaderIcons(
                                  title: "Reschedule",
                                  icon:
                                      "assets/images/funnels/icon_booking_reschedule.svg",
                                  onPressed: () {
                                    BlocProvider.of<BookingBloc>(context)
                                        .showDateTimePicker();
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              BlocBuilder<BookingBloc, BookingState>(
                                  builder: (blocBuilder, state) {
                                return BookingHeaderIcons(
                                  title: "Cancel",
                                  icon:
                                      "assets/images/funnels/icon_booking_cancel.svg",
                                  onPressed: () {
                                    BlocProvider.of<BookingBloc>(context)
                                        .showBookingCancelConfirmation();
                                  },
                                );
                              }),
                              SizedBox(
                                width: 10,
                              ),
                              BookingHeaderIcons(
                                title: "Done",
                                icon:
                                    "assets/images/funnels/icon_booking_done.svg",
                                iconColor: kAppIconColor,
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
                                            getCongratulatoryMsg(),
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
                                        '${state.bookingData!.lead!.leadUuid!.toUpperCase()}'),
                                Visibility(
                                  visible: state.bookingData!.lead!
                                          .appointmentDatetime !=
                                      null,
                                  child: BookingConfirmationDataComponent(
                                      title: 'Time Slot:',
                                      value: DateFormat("hh:mm a").format(
                                          DateTime.parse(state.bookingData!
                                                  .lead!.appointmentDatetime ??
                                              "2021-10-09T05:00:00.000+05:30"))),
                                ),
                                Visibility(
                                  visible: state.bookingData!.lead!
                                          .appointmentDatetime !=
                                      null,
                                  child: BookingConfirmationDataComponent(
                                      title: 'Appointment Date:',
                                      value: DateFormat("dd/MM/yyyy").format(
                                          DateTime.parse(state.bookingData!
                                                  .lead!.appointmentDatetime ??
                                              "2021-10-09T05:00:00.000+05:30"))),
                                )
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
                                        getShortlyAssignMsg(),
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            height: 1.5,
                                            color: Color(0x771A202E)),
                                      ),
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
                                            backgroundColor:
                                                Colors.red.shade500,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                state.bookingData!.lead!
                                                            .petHero ==
                                                        null
                                                    ? "Pet Hero"
                                                    : state.bookingData!.lead!
                                                            .petHero!.name ??
                                                        "Pet Hero",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    height: 1.5,
                                                    color: kAppIconColor,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              RichText(
                                                text: TextSpan(children: [
                                                  TextSpan(
                                                    text: "Service Ratings: ",
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        height: 1.5,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  WidgetSpan(
                                                      alignment:
                                                          PlaceholderAlignment
                                                              .middle,
                                                      child: Icon(
                                                        Icons.star_rounded,
                                                        size: 11,
                                                        color:
                                                            Color(0xFF00BE63),
                                                      )),
                                                  TextSpan(
                                                      text: state
                                                                  .bookingData!
                                                                  .lead!
                                                                  .petHero ==
                                                              null
                                                          ? "4.0"
                                                          : state
                                                                  .bookingData!
                                                                  .lead!
                                                                  .petHero!
                                                                  .rating ??
                                                              "3.2",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          height: 1.5,
                                                          color:
                                                              Color(0xFF00BE63),
                                                          fontWeight:
                                                              FontWeight.w700))
                                                ]),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.66,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/bookings/icon_sheild.png',
                                          height: 22,
                                          width: 22,
                                        ),
                                        SizedBox(
                                          width: 7,
                                        ),
                                        RichText(
                                          text: TextSpan(
                                              children: [
                                                TextSpan(
                                                    text:
                                                        '${state.bookingData!.lead!.petHero == null ? 109 : state.bookingData!.lead!.petHero!.jobsDone ?? 200} safe jobs ',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w300)),
                                                TextSpan(
                                                    text: 'done.',
                                                    style: TextStyle(
                                                        color: kAppIconColor,
                                                        fontWeight:
                                                            FontWeight.w500))
                                              ],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                  height: 1.5)),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 19.23),
                                    Divider(
                                      height: 1,
                                    ),
                                    SizedBox(height: 8.77),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                          onPressed: () async {
                                            {
                                              Uri emailLaunchUri = Uri(
                                                scheme: 'tel',
                                                path: '9354074426',
                                              );
                                              await canLaunch(
                                                      emailLaunchUri.toString())
                                                  ? launch(
                                                      emailLaunchUri.toString())
                                                  : showSnackbar(
                                                      context: context);
                                            }
                                          },
                                          child: Column(
                                            children: [
                                              SvgPicture.asset(
                                                'assets/images/bookings/icon_phone.svg',
                                                height: 19,
                                                width: 19,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                'Call',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    height: 1.5,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 72,
                                        ),
                                        Container(
                                          width: 1,
                                          height: 40,
                                          color: kAppBackgroundAltGray,
                                        ),
                                        SizedBox(
                                          width: 72,
                                        ),
                                        TextButton(
                                          onPressed: () {},
                                          child: Column(
                                            children: [
                                              SvgPicture.asset(
                                                'assets/images/bookings/icon_chat.svg',
                                                height: 19,
                                                width: 19,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                'Chat',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    height: 1.5,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.all(0)),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, kNavigationReferAndEarn);
                            },
                            child: Container(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Refer and Earn',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              height: 1.5,
                                              color: Colors.black),
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
                                                scrollDirection:
                                                    Axis.horizontal,
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
                                                            .packageDetails!
                                                            .name!
                                                        : '${state.bookingData!.lead!.leadPetPackages![index].package!.packageDetails!.name!}, ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12,
                                                        height: 1.5,
                                                        color:
                                                            Color(0x771A202E)),
                                                  );
                                                }),
                                          )
                                        ],
                                      ),
                                    ),
                                    //todo: populate this value based on response from the api
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: state.bookingData!.lead!
                                                              .paymentStatus ==
                                                          kPaymentStatusFullyPaid ||
                                                      state.bookingData!.lead!
                                                              .paymentStatus ==
                                                          kPaymentStatusOverPaid
                                                  ? Colors.green
                                                  : kAppIconColor),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      child: Text(
                                        state.bookingData!.lead!
                                                        .paymentStatus ==
                                                    kPaymentStatusFullyPaid ||
                                                state.bookingData!.lead!
                                                        .paymentStatus ==
                                                    kPaymentStatusOverPaid
                                            ? "Successful"
                                            : "Pending",
                                        style: TextStyle(
                                            height: 1.5,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: state.bookingData!.lead!
                                                            .paymentStatus !=
                                                        kPaymentStatusFullyPaid ||
                                                    state.bookingData!.lead!
                                                            .paymentStatus !=
                                                        kPaymentStatusOverPaid
                                                ? kAppIconColor
                                                : Colors.green),
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
                                      '\u{20B9} ${state.bookingData!.lead!.price!.totalPrice ?? 0}',
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
                          Visibility(
                            visible: state.bookingData!.lead!.paymentStatus !=
                                    kPaymentStatusFullyPaid ||
                                state.bookingData!.lead!.paymentStatus !=
                                    kPaymentStatusOverPaid,
                            child: TextButton(
                              onPressed: () => onBookingConfirmation.payOnline(
                                  blocContext, state.bookingData!),
                              child: Container(
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
                                  )),
                            ),
                          )
                        ],
                      );
              },
            ),
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
                      getTimeSlot(timeSlot: selectedTime),
                      leadType);
                },
                leadType: leadType,
              ));
        }),
        BlocBuilder<BookingBloc, BookingState>(builder: (blocContext, state) {
          return Visibility(
            visible: state.showBookingCancelConfirmation,
            child: Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight,
              color: Color(0x8D000000),
              child: Center(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [kContainerBoxShadow],
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 12.86,
                      ),
                      Text(
                        'Cancel Booking',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            height: 1.5,
                            color: Color(0xFFA3A6Ab)),
                      ),
                      SizedBox(
                        height: 8.38,
                      ),
                      SvgPicture.asset(
                          'assets/images/funnels/icon_confirm_cancel.svg'),
                      SizedBox(
                        height: 21,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Are you sure, you want to cancel Booking?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              height: 1.5,
                              color: Color(0xFF151724)),
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () {
                                BlocProvider.of<BookingBloc>(context)
                                    .cancelBooking(
                                        state.bookingData!.lead!.id!,
                                        leadType,
                                        state.bookingData!.lead!
                                                .appointmentDatetime ??
                                            '');
                              },
                              child: Container(
                                  height: 34,
                                  width: 106,
                                  decoration: kActiveButtonContainerBlueStyle,
                                  child: Center(
                                    child: Text(
                                      'Yes',
                                      style: TextStyle(
                                          fontSize: 14,
                                          height: 1.5,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ))),
                          TextButton(
                              onPressed: () {
                                BlocProvider.of<BookingBloc>(context)
                                    .hideBookingCancelConfirmation();
                              },
                              child: Container(
                                  height: 34,
                                  width: 106,
                                  decoration: kActiveButtonContainerStyle,
                                  child: Center(
                                    child: Text(
                                      'No',
                                      style: TextStyle(
                                          fontSize: 14,
                                          height: 1.5,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ))),
                          SizedBox(
                            height: 14,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
        BlocBuilder<BookingBloc, BookingState>(builder: (blocContext, state) {
          return Visibility(
            visible: fromFunnels && state.showBookingSuccessPopup,
            child: Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight,
              color: Color(0x8D000000),
              child: Center(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [kContainerBoxShadow],
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 12.86,
                      ),
                      Text(
                        'Booking Successful',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            height: 1.5,
                            color: Color(0xFFA3A6Ab)),
                      ),
                      SizedBox(
                        height: 8.38,
                      ),
                      SvgPicture.asset(
                          'assets/images/funnels/icon_booking_success.svg'),
                      SizedBox(
                        height: 15.57,
                      ),
                      Text(
                        currentFunnel == FunnelType.VET_SERVICE
                            ? "Thank You!"
                            : "Congratulation!",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            height: 1.5,
                            color: Color(0xFF151724)),
                      ),
                      SizedBox(
                        height: 6.99,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          currentFunnel == FunnelType.VET_SERVICE
                              ? 'Your  appointment with pet Expert has been successfully booked.'
                              : 'Your pet grooming appointment is successfully booked.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              height: 1.5,
                              color: Color(0xFF151724)),
                        ),
                      ),
                      SizedBox(
                        height: 21,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () {
                                BlocProvider.of<BookingBloc>(context)
                                    .hideBookingSuccessPopup();
                              },
                              child: Container(
                                height: 34,
                                width: 106,
                                decoration:
                                    currentFunnel == FunnelType.VET_SERVICE
                                        ? kActiveButtonContainerBlueStyle
                                        : kActiveButtonContainerStyle,
                                child: Center(
                                  child: Text(
                                    'Yes',
                                    style:
                                        currentFunnel == FunnelType.VET_SERVICE
                                            ? TextStyle(
                                                fontSize: 14,
                                                height: 1.5,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600)
                                            : TextStyle(
                                                fontSize: 14,
                                                height: 1.5,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
                                  ),
                                ),
                              )),
                          SizedBox(
                            height: 14,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        })
      ],
    );
  }

  String getCongratulatoryMsg() {
    if (currentFunnel == FunnelType.PET_GROOMING)
      return 'Your pet grooming appointment is successfully booked.';
    else if (currentFunnel == FunnelType.PET_TRAINING)
      return 'Your pet training appointment is successfully booked.';
    else
      return 'Your vet consultation appointment is successfully booked.';
  }

  String getShortlyAssignMsg() {
    if (currentFunnel == FunnelType.PET_GROOMING)
      return 'A professional groomer will be assigned 30 minutes before your appointment.';
    else if (currentFunnel == FunnelType.PET_TRAINING)
      return 'A professional trainer will be assigned 30 minutes before your appointment.';
    else
      return 'A professional vet expert will be assigned 30 minutes before your appointment.';
  }
}
