import 'package:equatable/equatable.dart';
import 'package:the_pet_nest/konstants/enums.dart';

class PaymentSelectionState extends Equatable {
  final PAYMENT_METHOD paymentMethod;

  PaymentSelectionState({this.paymentMethod = PAYMENT_METHOD.AFTER_SERVICE});

  PaymentSelectionState copyWith({PAYMENT_METHOD? paymentMethod}) {
    return PaymentSelectionState(
        paymentMethod: paymentMethod ?? this.paymentMethod);
  }

  @override
  List<Object?> get props => [paymentMethod];
}
