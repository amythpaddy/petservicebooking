import 'package:equatable/equatable.dart';
import 'package:the_pet_nest/funnels/model/bookedSlotsResponseModel.dart';

class DateTimeState extends Equatable {
  final String selectedDate;
  final bool showDateTimePicker;
  final bool gettingAvailableTimeSlots;
  BookedSlotsResponse? bookedSlots;
  final String selectedTime;

  DateTimeState(
      {this.selectedDate = "",
      this.showDateTimePicker = false,
      this.gettingAvailableTimeSlots = true,
      this.selectedTime = "",
      this.bookedSlots}) {
    bookedSlots = this.bookedSlots ?? BookedSlotsResponse();
  }

  DateTimeState copyWith(
      {bool? showDateTimePicker,
      String? selectedDate,
      bool? gettingAvailableTimeSlots,
      BookedSlotsResponse? bookedSlots,
      String? selectedTime}) {
    return DateTimeState(
        showDateTimePicker: showDateTimePicker ?? this.showDateTimePicker,
        selectedDate: selectedDate ?? this.selectedDate,
        gettingAvailableTimeSlots:
            gettingAvailableTimeSlots ?? this.gettingAvailableTimeSlots,
        bookedSlots: bookedSlots ?? this.bookedSlots,
        selectedTime: selectedTime ?? this.selectedTime);
  }

  @override
  List<Object?> get props => [
        selectedTime,
        selectedDate,
        gettingAvailableTimeSlots,
        bookedSlots,
        showDateTimePicker
      ];
}
