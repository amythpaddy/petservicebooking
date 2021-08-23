abstract class DateTimeSelectionInterface {
  void dateSelected(blocContext, String date);
  void timeSelected(blocContext, String time);
  void onDateTimeSelectionComplete(blocContext);
}
