import 'package:flutter/material.dart';

class TestPayment extends StatelessWidget {
  const TestPayment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: TextButton(
      onPressed: startPayment,
      child: Text('test payment'),
    ));
  }

  void startPayment() {
    // var response = AllInOneSdk.startTransaction(
    //     "mid", "ord123", "100", txnToken, null, isStaging, restrictAppInvoke);
    // response.then((value) {
    //   print(value);
    //   setState(() {
    //     result = value.toString();
    //   });
    // }).catchError((onError) {
    //   if (onError is PlatformException) {
    //     setState(() {
    //       result = onError.message + " \n  " + onError.details.toString();
    //     });
    //   } else {
    //     setState(() {
    //       result = onError.toString();
    //     });
    //   }
    // });
  }
}
