import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:the_pet_nest/funnels/model/bookingConfirmationResponseModel.dart';
import 'package:the_pet_nest/funnels/model/paymentPostData.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen(
      {Key? key, required this.bookingConfirmationData, required this.leadType})
      : super(key: key);
  final BookingConfirmationData bookingConfirmationData;
  final String leadType;

  @override
  _PaymentScreenState createState() => _PaymentScreenState(leadType);
}

class _PaymentScreenState extends State<PaymentScreen> {
  WebViewController? _controller;
  bool loading = false;
  String leadType;
  _PaymentScreenState(this.leadType);

  @override
  void dispose() {
    _controller = null;
    super.dispose();
  }

  void getPaytmResponse() {
    _controller!.evaluateJavascript("document.body.innerText").then((value) {
      Map<String, dynamic> responseJSON = jsonDecode(value);
      final paytmResponse = responseJSON["data"]["success"];
      Navigator.pop(context, paytmResponse);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: WebView(
            debuggingEnabled: false,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (controller) {
              print(htmlPostData(
                  widget.bookingConfirmationData.lead!.id, leadType));
              _controller = controller;
              _controller!.loadUrl(
                Uri.dataFromString(
                        htmlPostData(
                            widget.bookingConfirmationData.lead!.id, leadType),
                        mimeType: 'text/html')
                    .toString(),
              );
            },
            onPageFinished: (page) {
              if (page.contains('mobile_confirm_payment')) getPaytmResponse();
            },
          ),
        ),
      ),
    );
  }
}
