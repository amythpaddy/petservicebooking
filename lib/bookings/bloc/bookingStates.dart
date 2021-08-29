import 'package:equatable/equatable.dart';
import 'package:the_pet_nest/bookings/model/bookingDataModel.dart';
import 'package:the_pet_nest/funnels/model/bookingConfirmationResponseModel.dart';
import 'package:the_pet_nest/konstants/enums.dart';

class BookingState extends Equatable {
  final bool initialLoad;
  final String date;
  final String time;
  final bool rescheduling;
  final bool rescheduled;
  final bool error;
  final bool showDateTimePicker;
  final bool isProcessing;
  final BookingConfirmationData? bookingData;
  final int currentPage;
  final BookingsDataResponseModel? bookingsList;
  final BookingType bookingType;

  BookingState(
      {this.date = '',
      this.time = '',
      this.rescheduling = false,
      this.rescheduled = false,
      this.error = false,
      this.showDateTimePicker = false,
      this.isProcessing = false,
      this.bookingData,
      this.currentPage = 1,
      this.bookingsList,
      this.bookingType = BookingType.ONGOING,
      this.initialLoad = true});

  BookingState copyWith(
      {String? date,
      String? time,
      bool? rescheduling,
      bool? rescheduled,
      bool? error,
      bool? showDateTimePicker,
      bool? isProcessing,
      BookingConfirmationData? bookingData,
      int? currentPage,
      BookingsDataResponseModel? bookingsList,
      BookingType? bookingType}) {
    print('aaaaaa$bookingData');
    return BookingState(
        date: date ?? this.date,
        time: time ?? this.time,
        rescheduled: rescheduled ?? this.rescheduled,
        rescheduling: rescheduling ?? this.rescheduling,
        error: error ?? this.error,
        showDateTimePicker: showDateTimePicker ?? this.showDateTimePicker,
        isProcessing: isProcessing ?? this.isProcessing,
        bookingData: bookingData ?? this.bookingData,
        currentPage: currentPage ?? this.currentPage,
        bookingsList: bookingsList ?? this.bookingsList,
        bookingType: bookingType ?? this.bookingType,
        initialLoad: false);
  }

  @override
  List<Object?> get props => [
        date,
        time,
        rescheduled,
        rescheduling,
        error,
        showDateTimePicker,
        isProcessing,
        bookingData,
        currentPage,
        bookingsList,
        bookingType,
        initialLoad
      ];
}
