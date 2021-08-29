abstract class BookingConfirmationInterface {
  void onReschedule(blocContext);
  void onCancelBooking(blocContext);
  void onMakeCall(blocContext, String phoneNumber);
}
