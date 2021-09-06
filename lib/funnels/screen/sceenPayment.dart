import 'package:flutter/material.dart';
import 'package:the_pet_nest/funnels/model/bookingConfirmationResponseModel.dart';
import 'package:the_pet_nest/funnels/model/paymentPostData.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key, required this.bookingConfirmationData})
      : super(key: key);
  final BookingConfirmationData bookingConfirmationData;

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  WebViewController? _controller;

  @override
  void dispose() {
    _controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: WebView(
          debuggingEnabled: false,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (controller) {
            print(htmlPostData(widget.bookingConfirmationData.lead!.id,
                widget.bookingConfirmationData.lead!.leadType));
            _controller = controller;
            _controller!.loadUrl(
              Uri.dataFromString(
                      htmlPostData(widget.bookingConfirmationData.lead!.id,
                          widget.bookingConfirmationData.lead!.leadType),
                      mimeType: 'text/html')
                  .toString(),
            );
          },
        ),
      ),
    );
  }
}
