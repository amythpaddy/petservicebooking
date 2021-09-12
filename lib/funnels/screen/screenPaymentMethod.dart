import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_pet_nest/funnels/bloc/paymentSelectionBloc/paymentSelectionBloc.dart';
import 'package:the_pet_nest/funnels/bloc/paymentSelectionBloc/paymentSelectionState.dart';
import 'package:the_pet_nest/funnels/interfaces/paymentMethodSelectionInterface.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/enums.dart';
import 'package:the_pet_nest/konstants/styles.dart';

class ScreenPaymentMethod extends StatelessWidget {
  const ScreenPaymentMethod({
    Key? key,
    required this.onPaymentMethodSelected,
    required this.totalPrice,
  }) : super(key: key);
  final double totalPrice;
  final PaymentMethodSelectionInterface onPaymentMethodSelected;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 19.36, vertical: 24.59),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Payment Method',
                    style: kFunnelScreenHeadingTextStyle,
                  ),
                  SizedBox(
                    height: 16.6,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        boxShadow: [kContainerBoxShadow]),
                    child: BlocBuilder<PaymentSelectionBloc,
                        PaymentSelectionState>(
                      builder: (blocContext, state) {
                        return Column(
                          children: [
                            ListTile(
                                leading: SvgPicture.asset(
                                  'assets/images/funnels/icon_payment_online.svg',
                                  width: 24,
                                  height: 24,
                                ),
                                title: Text('Pay Online'),
                                trailing: Radio<PAYMENT_METHOD>(
                                  value: PAYMENT_METHOD.ONLINE,
                                  groupValue: state.paymentMethod,
                                  onChanged: (value) {
                                    onPaymentMethodSelected
                                        .onPaymentMethodChange(
                                            blocContext, value!);
                                    BlocProvider.of<PaymentSelectionBloc>(
                                            blocContext)
                                        .setPaymentMethodToOnline();
                                  },
                                ),
                                onTap: () {
                                  onPaymentMethodSelected.onPaymentMethodChange(
                                      blocContext, PAYMENT_METHOD.ONLINE);
                                  BlocProvider.of<PaymentSelectionBloc>(
                                          blocContext)
                                      .setPaymentMethodToOnline();
                                }),
                            Divider(
                              indent: 50,
                              endIndent: 50,
                            ),
                            ListTile(
                                leading: SvgPicture.asset(
                                  'assets/images/funnels/icon_payment_cash.svg',
                                  width: 24,
                                  height: 24,
                                ),
                                title: Text('Pay After Service'),
                                trailing: Radio<PAYMENT_METHOD>(
                                  value: PAYMENT_METHOD.AFTER_SERVICE,
                                  groupValue: state.paymentMethod,
                                  onChanged: (value) {
                                    onPaymentMethodSelected
                                        .onPaymentMethodChange(
                                            blocContext, value!);
                                    BlocProvider.of<PaymentSelectionBloc>(
                                            blocContext)
                                        .setPaymentMethodToAfterService();
                                  },
                                ),
                                onTap: () {
                                  onPaymentMethodSelected.onPaymentMethodChange(
                                      blocContext,
                                      PAYMENT_METHOD.AFTER_SERVICE);
                                  BlocProvider.of<PaymentSelectionBloc>(
                                          blocContext)
                                      .setPaymentMethodToAfterService();
                                }),
                          ],
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 13),
            decoration: BoxDecoration(
                color: Colors.white, boxShadow: [kContainerBoxShadow]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    '\u{20B9} $totalPrice',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: kAppIconColor),
                  ),
                  Text(
                    '',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                        height: 1.5,
                        color: kTextColorBlue),
                  )
                ]),
                BlocBuilder<PaymentSelectionBloc, PaymentSelectionState>(
                    builder: (blocContext, state) {
                  return TextButton(
                      onPressed: () {
                        if (!state.confirmingBooking) {
                          BlocProvider.of<PaymentSelectionBloc>(blocContext)
                              .processingBooking();
                          onPaymentMethodSelected
                              .onPaymentMethodSelectionComplete(context);
                        }
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        decoration: kActiveButtonContainerStyle,
                        child: state.confirmingBooking
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                state.paymentMethod == PAYMENT_METHOD.ONLINE
                                    ? 'Proceed to Pay'
                                    : 'Confirm Booking',
                                style: kActiveButtonTextStyle,
                              ),
                      ));
                })
              ],
            ),
          )
        ],
      ),
    );
  }
}
