import 'package:the_pet_nest/konstants/enums.dart';

abstract class PaymentMethodSelectionInterface {
  void onPaymentMethodChange(blocContext, PAYMENT_METHOD paymentMethod);
  void onPaymentMethodSelectionComplete(blocContext);
}
