import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_pet_nest/addressBook/model/addressBookModel.dart';
import 'package:the_pet_nest/funnels/bloc/funnelEvent.dart';
import 'package:the_pet_nest/funnels/bloc/funnelState.dart';
import 'package:the_pet_nest/funnels/model/bookingConfirmationResponseModel.dart';
import 'package:the_pet_nest/funnels/model/couponseApiResponseModel.dart';
import 'package:the_pet_nest/funnels/model/createOrderRequestModel.dart';
import 'package:the_pet_nest/funnels/model/packageDetailApiResponseModel.dart';
import 'package:the_pet_nest/konstants/endpoints.dart';
import 'package:the_pet_nest/konstants/enums.dart';
import 'package:the_pet_nest/profiles/model/getPetListModel.dart';
import 'package:the_pet_nest/utils/ApiCaller.dart';

class PetGroomingBloc extends Bloc<FunnelEvent, FunnelState> {
  FunnelScreens _currentScreen = FunnelScreens.SCREEN_ADDRESS_SELECTION;
  Address? _address;
  List<CustomerPet> _petData = [];
  List<PackageDetailModel> _packageDetail = [];
  String _date = '';
  String _time = '';
  PAYMENT_METHOD _paymentMethod = PAYMENT_METHOD.AFTER_SERVICE;
  int _currentServiceEntryIndex = 0;
  double _discountPrice = 0.0;
  double _totalPrice = 0.0;
  CouponData? _couponData;
  BookingConfirmationData? _bookingConfirmationData;

  PetGroomingBloc(FunnelState initialState) : super(initialState) {
    add(FunnelEvent.UPDATE_PROGRESS_INDICATOR);
  }
  static const _TOTAL_SCREENS = 7;
  double _progressIndicator = 1 / _TOTAL_SCREENS;

  void setPayment(PAYMENT_METHOD paymentMethod) {
    _paymentMethod = paymentMethod;
  }

  void addNewService() {
    _currentServiceEntryIndex++;
    openPetSelectionScreen();
  }

  void setDateTime({String date = "", String time = ""}) {
    if (date.isNotEmpty) {
      _date = date;
    }
    if (time.isNotEmpty) {
      _time = time;
    }
  }

  void setAddress(Address? address) {
    _address = address;
  }

  void openAddressSelectionScreen() {
    _currentScreen = FunnelScreens.SCREEN_ADDRESS_SELECTION;
    _progressIndicator = 1 / _TOTAL_SCREENS;
    add(FunnelEvent.OPEN_SCREEN_ADDRESS_SELECTION);
  }

  void openPetSelectionScreen() {
    if (_address == null) {
      add(FunnelEvent.ADDRESS_NOT_SELECTED);
    } else {
      _currentScreen = FunnelScreens.SCREEN_PET_SELECTION;
      _progressIndicator = 2 / _TOTAL_SCREENS;
      add(FunnelEvent.OPEN_SCREEN_PET_SELECTION);
    }
  }

  void setPet(CustomerPet petData) {
    try {
      _petData.removeAt(_currentServiceEntryIndex);
    } catch (e) {}
    _petData.insert(_currentServiceEntryIndex, petData);
  }

  void openPackageSelectionScreen() {
    if (_petData.length <= _currentServiceEntryIndex) {
      add(FunnelEvent.PET_NOT_SELECTED);
    } else {
      _currentScreen = FunnelScreens.SCREEN_PACKAGE_SELECTION;
      _progressIndicator = 3 / _TOTAL_SCREENS;
      add(FunnelEvent.OPEN_SCREEN_PACKAGE_SELECTION);
    }
  }

  void setPackage(PackageDetailModel packageDetail) {
    try {
      _packageDetail.removeAt(_currentServiceEntryIndex);
    } catch (e) {}
    _packageDetail.insert(_currentServiceEntryIndex, packageDetail);
    _totalPrice = 0;
    _packageDetail.forEach((element) {
      _totalPrice += double.parse(element.price!);
    });
  }

  void openBookingDetailsReviewScreen() {
    if (_packageDetail.length <= _currentServiceEntryIndex) {
      add(FunnelEvent.PACKAGE_NOT_SELECTED);
    } else {
      _currentScreen = FunnelScreens.SCREEN_REVIEW_BOOKING_DETAILS;
      _progressIndicator = 4 / _TOTAL_SCREENS;
      add(FunnelEvent.OPEN_SCREEN_REVIEW_BOOKING_DETAIL);
    }
  }

  void couponSelected(CouponData couponData) {
    _couponData = couponData;
  }

  void openDateTimeSelectionScreen() {
    _currentScreen = FunnelScreens.SCREEN_DATE_TIME_SELECTION;
    _progressIndicator = _progressIndicator = 5 / _TOTAL_SCREENS;
    add(FunnelEvent.OPEN_SCREEN_DATE_TIME_SELECTION);
  }

  void openPaymentMethodScreen() {
    if (_time.isEmpty) {
      add(FunnelEvent.SLOT_NOT_SELECTED);
    } else {
      _currentScreen = FunnelScreens.SCREEN_PAYMENT_METHOD;
      _progressIndicator = 5 / _TOTAL_SCREENS;
      add(FunnelEvent.OPEN_SCREEN_CHOOSE_PAYMENT_METHOD);
    }
  }

  void processBooking() async {
    if (_paymentMethod == PAYMENT_METHOD.ONLINE) {
      //todo make transaction first and then confirm
    } else {
      confirmBooking();
    }
    // var value = Api.
  }

  void openCouponScreen() {
    _currentScreen = FunnelScreens.SCREEN_COUPONS_SELECTION;
    _progressIndicator = 0;
    add(FunnelEvent.OPEN_SCREEN_COUPONS_SELECTION);
  }

  void applyDiscount(double discountValue) {
    _discountPrice = discountValue;
    openPaymentMethodScreen();
    add(FunnelEvent.DISCOUNT_ADDED);
  }

  void goBack() {
    switch (_currentScreen) {
      case FunnelScreens.SCREEN_ADDRESS_SELECTION:
      case FunnelScreens.SCREEN_BOOKING_CONFIRMED:
      case FunnelScreens.SCREEN_BOOKING_CANCELLED:
        add(FunnelEvent.CLOSE_FUNNEL);
        break;
      case FunnelScreens.SCREEN_PACKAGE_SELECTION:
        openPetSelectionScreen();
        break;
      case FunnelScreens.SCREEN_PET_SELECTION:
        openAddressSelectionScreen();
        break;
      case FunnelScreens.SCREEN_REVIEW_BOOKING_DETAILS:
        openPackageSelectionScreen();
        break;
      case FunnelScreens.SCREEN_PAYMENT_METHOD:
        openDateTimeSelectionScreen();
        break;
      case FunnelScreens.SCREEN_COUPONS_SELECTION:
        openBookingDetailsReviewScreen();
        break;
      case FunnelScreens.SCREEN_DATE_TIME_SELECTION:
        openBookingDetailsReviewScreen();
    }
  }

  @override
  Stream<FunnelState> mapEventToState(FunnelEvent event) async* {
    if (event == FunnelEvent.OPEN_SCREEN_ADDRESS_SELECTION ||
        event == FunnelEvent.OPEN_SCREEN_COUPONS_SELECTION) {
      yield state.copyWith(
          progressIndicator: _progressIndicator, currentScreen: _currentScreen);
    }
    if (event == FunnelEvent.UPDATE_PROGRESS_INDICATOR) {
      yield state.copyWith(progressIndicator: _progressIndicator);
    } else if (event == FunnelEvent.OPEN_SCREEN_PET_SELECTION) {
      yield state.copyWith(
          currentScreen: _currentScreen,
          progressIndicator: _progressIndicator,
          citySlug: _address!.citySlug,
          address: _address);
    } else if (event == FunnelEvent.ADDRESS_NOT_SELECTED) {
      yield state.copyWith(
          showError: true, errorMessage: "No Address Selected");
    } else if (event == FunnelEvent.OPEN_SCREEN_PACKAGE_SELECTION) {
      yield state.copyWith(
          currentScreen: _currentScreen,
          progressIndicator: _progressIndicator,
          petCategory:
              _petData[_currentServiceEntryIndex].subcategory!.name == "cat"
                  ? PetCategory.CAT
                  : PetCategory.DOG,
          petData: _petData);
    } else if (event == FunnelEvent.PET_NOT_SELECTED) {
      yield state.copyWith(showError: true, errorMessage: "No Pet Selected");
    } else if (event == FunnelEvent.CLOSE_FUNNEL) {
      yield state.copyWith(closeThisFunnel: true);
    } else if (event == FunnelEvent.PACKAGE_NOT_SELECTED) {
      yield state.copyWith(
          showError: true, errorMessage: "No Package Selected");
    } else if (event == FunnelEvent.OPEN_SCREEN_REVIEW_BOOKING_DETAIL) {
      yield state.copyWith(
          currentScreen: _currentScreen,
          progressIndicator: _progressIndicator,
          packageDetail: _packageDetail,
          totalPrice: _totalPrice);
    } else if (event == FunnelEvent.OPEN_SCREEN_CHOOSE_PAYMENT_METHOD) {
      yield state.copyWith(
          currentScreen: _currentScreen, progressIndicator: _progressIndicator);
    } else if (event == FunnelEvent.SLOT_NOT_SELECTED) {
      yield state.copyWith(errorMessage: "No Slot Selected", showError: true);
    } else if (event == FunnelEvent.DISCOUNT_ADDED) {
      yield state.copyWith(discountPrice: _discountPrice);
    } else if (event == FunnelEvent.OPEN_SCREEN_DATE_TIME_SELECTION) {
      yield state.copyWith(currentScreen: _currentScreen);
    } else if (event == FunnelEvent.OPEN_SCREEN_BOOKING_CONFIRMATION) {
      yield state.copyWith(
          progressIndicator: _progressIndicator,
          currentScreen: _currentScreen,
          bookingConfirmationData: _bookingConfirmationData);
    }
  }

  void confirmBooking() async {
    add(FunnelEvent.CONFIRMING_BOOKING);
    Map<String, dynamic> body = CreateOrderRequestModel.fromUserSelectedData(
        address: _address,
        customerPet: _petData,
        packageDetail: _packageDetail,
        date: _date,
        time: _time,
        couponData: _couponData);
    var response =
        await ApiCaller.post(kUrlCreateGroomingLead, body, withToken: true);
    BookingConfirmationResponseModel responseModel =
        BookingConfirmationResponseModel.fromJson(response);
    if (responseModel.data != null) {
      _bookingConfirmationData = responseModel.data;
      _progressIndicator = 7 / _TOTAL_SCREENS;
      _currentScreen = FunnelScreens.SCREEN_BOOKING_CONFIRMED;
      add(FunnelEvent.OPEN_SCREEN_BOOKING_CONFIRMATION);
    } else {
      _progressIndicator = 7 / _TOTAL_SCREENS;
      _currentScreen = FunnelScreens.SCREEN_BOOKING_CANCELLED;
      add(FunnelEvent.OPEN_SCREEN_BOOKING_CANCELLATION);
    }
  }
}
