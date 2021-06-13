import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_pet_nest/funnels/petTraining/model/petTrainingFunnelDataHolder.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/styles.dart';

class ScreenPaymentMethod extends StatefulWidget {
  const ScreenPaymentMethod(
      {Key? key,
      required this.screenPaymentMethodResponse,
      required this.dataHolder})
      : super(key: key);
  final Function screenPaymentMethodResponse;
  final PetTrainingFunnelDataHolder dataHolder;

  @override
  _ScreenPaymentMethodState createState() =>
      _ScreenPaymentMethodState(screenPaymentMethodResponse, dataHolder);
}

enum PAYMENT_METHOD { ONLINE, AFTER_SERVICE }

class _ScreenPaymentMethodState extends State<ScreenPaymentMethod> {
  final Function screenPaymentMethodResponse;
  final PetTrainingFunnelDataHolder dataHolder;
  PAYMENT_METHOD _paymentMethod = PAYMENT_METHOD.ONLINE;

  _ScreenPaymentMethodState(this.screenPaymentMethodResponse, this.dataHolder);

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
                    child: Column(
                      children: [
                        ListTile(
                          leading: SvgPicture.asset(
                            'assets/images/funnels/icon_payment_online.svg',
                            width: 24,
                            height: 24,
                          ),
                          title: Text('Pay online'),
                          trailing: Radio<PAYMENT_METHOD>(
                            value: PAYMENT_METHOD.ONLINE,
                            groupValue: _paymentMethod,
                            onChanged: (PAYMENT_METHOD? value) {
                              setState(() {
                                _paymentMethod = value!;
                              });
                            },
                          ),
                          onTap: () {
                            setState(() {
                              _paymentMethod = PAYMENT_METHOD.ONLINE;
                            });
                          },
                        ),
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
                          title: Text('Pay online'),
                          trailing: Radio<PAYMENT_METHOD>(
                            value: PAYMENT_METHOD.AFTER_SERVICE,
                            groupValue: _paymentMethod,
                            onChanged: (PAYMENT_METHOD? value) {
                              setState(() {
                                _paymentMethod = value!;
                              });
                            },
                          ),
                          onTap: () {
                            setState(() {
                              _paymentMethod = PAYMENT_METHOD.AFTER_SERVICE;
                            });
                          },
                        ),
                      ],
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
                    '\u{20B9} 1800',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: kAppIconColor),
                  ),
                  Text(
                    'View Details',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                        height: 1.5,
                        color: kTextColorBlue),
                  )
                ]),
                TextButton(
                    onPressed: () => screenPaymentMethodResponse(dataHolder),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration: kActiveButtonContainerStyle,
                      child: Text(
                        'Proceed to Pay',
                        style: kActiveButtonTextStyle,
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
