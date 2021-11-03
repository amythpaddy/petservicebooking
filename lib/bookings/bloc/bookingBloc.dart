import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_pet_nest/bookings/bloc/bookingEvents.dart';
import 'package:the_pet_nest/bookings/bloc/bookingStates.dart';
import 'package:the_pet_nest/bookings/model/bookingDataModel.dart';
import 'package:the_pet_nest/funnels/model/bookingConfirmationResponseModel.dart';
import 'package:the_pet_nest/konstants/endpoints.dart';
import 'package:the_pet_nest/konstants/enums.dart';
import 'package:the_pet_nest/konstants/values.dart';
import 'package:the_pet_nest/utils/ApiCaller.dart';

class BookingBloc extends Bloc<BookingEvents, BookingState> {
  BookingBloc(BookingState initialState) : super(initialState);
  BookingConfirmationData? _bookingData;
  BookingsDataResponseModel? _bookingsList;

  void getBookings({required int page}) async {
    add(BookingEvents.PROCESSING);
    // var response = await ApiCaller.get(kUrlGetBookings(page), withToken: true);
    var response = await ApiCaller.get(kUrlGetOrdersGrooming, withToken: true);
    _bookingsList =
        BookingsDataResponseModel.fromJson(response, kLeadTypeGrooming);
    response = await ApiCaller.get(kUrlGetOrdersVet, withToken: true);
    _bookingsList!.data!.addAll(
        BookingsDataResponseModel.fromJson(response, kLeadTypeVet).data!);
    response = await ApiCaller.get(kUrlGetOrdersTraining, withToken: true);
    _bookingsList!.data!.addAll(
        BookingsDataResponseModel.fromJson(response, kLeadTypeTraining).data!);
    add(BookingEvents.BOOKINGS_FETCHED);
  }

  void showBookingCancelConfirmation() {
    add(BookingEvents.SHOW_BOOKING_CANCEL_CONFIRMATION);
  }

  void hideBookingCancelConfirmation() {
    add(BookingEvents.HIDE_BOOKING_CANCEL_CONFIRMATION);
  }

  void showDateTimePicker() {
    add(BookingEvents.SHOW_DATE_PICKER);
  }

  void hideDatePicker() {
    add(BookingEvents.HIDE_DATE_PICKER);
  }

  void getOngoingBookings() {
    add(BookingEvents.GET_ONGOING_BOOKINGS);
  }

  void getBookingsHistory() {
    add(BookingEvents.GET_HISTORY_BOOKINGS);
  }

  void onDateSelected() {}

  void updateBookingData(BookingConfirmationData bookingData) {
    _bookingData = bookingData;
    add(BookingEvents.UPDATE_BOOKING_DATA);
  }

  void hideBookingSuccessPopup() {
    add(BookingEvents.HIDE_BOOKING_SUCCESS_POPUP);
  }

  @override
  Stream<BookingState> mapEventToState(BookingEvents event) async* {
    if (event == BookingEvents.SHOW_DATE_PICKER) {
      yield state.copyWith(showDateTimePicker: true);
    } else if (event == BookingEvents.HIDE_DATE_PICKER) {
      yield state.copyWith(showDateTimePicker: false);
    } else if (event == BookingEvents.UPDATE_BOOKING_DATA) {
      yield state.copyWith(bookingData: _bookingData, isProcessing: false);
    } else if (event == BookingEvents.BOOKINGS_FETCHED) {
      yield state.copyWith(bookingsList: _bookingsList, isProcessing: false);
    } else if (event == BookingEvents.PROCESSING) {
      yield state.copyWith(isProcessing: true);
    } else if (event == BookingEvents.GET_ONGOING_BOOKINGS) {
      yield state.copyWith(bookingType: BookingType.ONGOING);
    } else if (event == BookingEvents.GET_HISTORY_BOOKINGS) {
      yield state.copyWith(bookingType: BookingType.HISTORY);
    } else if (event == BookingEvents.BOOKING_CANCELLED) {
      yield state.copyWith(bookingCancelled: true);
    } else if (event == BookingEvents.HIDE_BOOKING_CANCEL_CONFIRMATION) {
      yield state.copyWith(showBookingCancelConfirmation: false);
    } else if (event == BookingEvents.SHOW_BOOKING_CANCEL_CONFIRMATION) {
      yield state.copyWith(showBookingCancelConfirmation: true);
    } else if (event == BookingEvents.HIDE_BOOKING_SUCCESS_POPUP) {
      yield state.copyWith(showBookingSuccessPopup: false);
    }
  }

  void reschedule(String leadId, String selectedDate, String selectedTime,
      String leadType) async {
    add(BookingEvents.PROCESSING);
    add(BookingEvents.HIDE_DATE_PICKER);
    Map<String, dynamic> leadDateTime = Map();
    leadDateTime["appointment_datetime"] = '$selectedDate $selectedTime';
    Map<String, dynamic> data = Map();

    switch (leadType) {
      case 'grooming':
        data["lead"] = leadDateTime;
        break;
      case 'training':
        data["dog_training_lead"] = leadDateTime;
        break;
      default:
        data["vet_lead"] = leadDateTime;
    }

    var response = await ApiCaller.put(
        kUrlUpdateBookingDetail(leadId, leadType), data,
        withToken: true);
    BookingConfirmationResponseModel _bookingRescheduledData =
        BookingConfirmationResponseModel.fromJson(response, leadType);
    _bookingData = _bookingRescheduledData.data;
    add(BookingEvents.UPDATE_BOOKING_DATA);
  }

  void getBookingDetails(int leadId, String leadType) async {
    add(BookingEvents.PROCESSING);
    var response = await ApiCaller.get(kUrlGetBookingDetail(leadId, leadType),
        withToken: true);

    BookingConfirmationResponseModel _bookingRescheduledData =
        BookingConfirmationResponseModel.fromJson(response, leadType);
    _bookingData = _bookingRescheduledData.data;

    add(BookingEvents.UPDATE_BOOKING_DATA);
  }

  void cancelBooking(
      int leadId, String leadType, String appointmentDateTime) async {
    var response = await ApiCaller.post(kUrlCancelBooking(leadId, leadType),
        {"appointment_datetime": appointmentDateTime},
        withToken: true);
    if (response["data"]["success"]) add(BookingEvents.BOOKING_CANCELLED);
  }
}
