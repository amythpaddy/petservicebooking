import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_pet_nest/funnels/bloc/paymentSelectionBloc/paymentSelectionEvent.dart';
import 'package:the_pet_nest/funnels/bloc/paymentSelectionBloc/paymentSelectionState.dart';
import 'package:the_pet_nest/konstants/enums.dart';

class PaymentSelectionBloc
    extends Bloc<PaymentSelectionEvent, PaymentSelectionState> {
  PaymentSelectionBloc(PaymentSelectionState initialState)
      : super(initialState);

  void setPaymentMethodToOnline() {
    add(PaymentSelectionEvent.PAYMENT_METHOD_CHANGED_ONLINE);
  }

  void setPaymentMethodToAfterService() {
    add(PaymentSelectionEvent.PAYMENT_METHOD_CHANGED_AFTER_SERVICE);
  }

  @override
  Stream<PaymentSelectionState> mapEventToState(
      PaymentSelectionEvent event) async* {
    if (event == PaymentSelectionEvent.PAYMENT_METHOD_CHANGED_ONLINE) {
      yield state.copyWith(paymentMethod: PAYMENT_METHOD.ONLINE);
    } else if (event ==
        PaymentSelectionEvent.PAYMENT_METHOD_CHANGED_AFTER_SERVICE) {
      yield state.copyWith(paymentMethod: PAYMENT_METHOD.AFTER_SERVICE);
    } else if (event == PaymentSelectionEvent.PROCESSING_BOOKING) {
      yield state.copyWith(confirmingBooking: true);
    }
  }

  void processingBooking() {
    add(PaymentSelectionEvent.PROCESSING_BOOKING);
  }
}
