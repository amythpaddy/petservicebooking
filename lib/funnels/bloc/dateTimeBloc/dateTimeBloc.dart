import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:the_pet_nest/funnels/bloc/dateTimeBloc/dateTimeEvent.dart';
import 'package:the_pet_nest/funnels/bloc/dateTimeBloc/dateTimeState.dart';
import 'package:the_pet_nest/funnels/model/bookedSlotsResponseModel.dart';
import 'package:the_pet_nest/konstants/endpoints.dart';
import 'package:the_pet_nest/utils/ApiCaller.dart';

class DateTimeBloc extends Bloc<DateTimeEvent, DateTimeState> {
  DateTimeBloc(initialState) : super(initialState);
  String _date = '';
  String _time = '';
  final int _cityId = 1;

  var _response;

  void getBookedTimeSlots() async {
    add(DateTimeEvent.FETCHING_BOOKED_TIME_LIST);
    _response = await ApiCaller.get(kUrlGetBookedTimeSlots(_date, _cityId),
        withToken: true);
    add(DateTimeEvent.BOOKED_TIME_LIST_FETCHED);
  }

  void showDateTimePicker() {
    add(DateTimeEvent.SHOW_DATE_TIME_PICKER);
  }

  void hideDateTimePicker() {
    add(DateTimeEvent.HIDE_DATE_TIME_PICKER);
  }

  void setDate(DateTime date, {String? format}) {
    String compareDate = DateFormat(format ?? 'dd/MM/yyyy').format(date);
    if (compareDate != _date) {
      _date = compareDate;
      getBookedTimeSlots();
      add(DateTimeEvent.DATE_SELECTED_BY_USER);
    }
    add(DateTimeEvent.HIDE_DATE_TIME_PICKER);
  }

  void setTime(String timeSlot) {
    _time = timeSlot;
    add(DateTimeEvent.TIME_SELECTED_BY_USER);
  }

  @override
  Stream<DateTimeState> mapEventToState(event) async* {
    if (event == DateTimeEvent.SHOW_DATE_TIME_PICKER) {
      yield state.copyWith(showDateTimePicker: true);
    } else if (event == DateTimeEvent.HIDE_DATE_TIME_PICKER) {
      yield state.copyWith(
          showDateTimePicker: false, selectedDate: _date, selectedTime: "");
    } else if (event == DateTimeEvent.FETCHING_BOOKED_TIME_LIST) {
      yield state.copyWith(gettingAvailableTimeSlots: true);
    } else if (event == DateTimeEvent.BOOKED_TIME_LIST_FETCHED) {
      yield state.copyWith(
          gettingAvailableTimeSlots: false,
          bookedSlots: BookedSlotsResponse.fromJson(_response));
    } else if (event == DateTimeEvent.TIME_SELECTED_BY_USER) {
      yield state.copyWith(selectedTime: _time);
    } else if (event == DateTimeEvent.DATE_SELECTED_BY_USER) {
      yield state.copyWith(selectedDate: _date, selectedTime: "");
    }
  }
}
