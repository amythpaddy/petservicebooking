import 'package:the_pet_nest/funnels/model/bookingConfirmationResponseModel.dart';

abstract class BookingConfirmationInterface {
  void onReschedule(blocContext);
  void onCancelBooking(blocContext);
  void onMakeCall(blocContext, String phoneNumber);
  void payOnline(blocContext, BookingConfirmationData bookingConfirmationData);
}
