import 'package:equatable/equatable.dart';
import 'package:the_pet_nest/konstants/enums.dart';

class PaymentSelectionState extends Equatable {
  final PAYMENT_METHOD paymentMethod;
  final bool confirmingBooking;

  PaymentSelectionState(
      {this.paymentMethod = PAYMENT_METHOD.AFTER_SERVICE,
      this.confirmingBooking = false});

  PaymentSelectionState copyWith(
      {PAYMENT_METHOD? paymentMethod, bool? confirmingBooking}) {
    return PaymentSelectionState(
        paymentMethod: paymentMethod ?? this.paymentMethod,
        confirmingBooking: confirmingBooking ?? this.confirmingBooking);
  }

  @override
  List<Object?> get props => [paymentMethod, confirmingBooking];
}
