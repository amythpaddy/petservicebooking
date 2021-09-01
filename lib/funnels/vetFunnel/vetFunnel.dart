import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_pet_nest/addressBook/bloc/addressBookBloc.dart';
import 'package:the_pet_nest/addressBook/bloc/addressBookState.dart';
import 'package:the_pet_nest/addressBook/model/addressBookModel.dart';
import 'package:the_pet_nest/bookings/bloc/bookingBloc.dart';
import 'package:the_pet_nest/bookings/bloc/bookingStates.dart';
import 'package:the_pet_nest/funnels/bloc/VetBloc.dart';
import 'package:the_pet_nest/funnels/bloc/couponBloc/couponBloc.dart';
import 'package:the_pet_nest/funnels/bloc/couponBloc/couponState.dart';
import 'package:the_pet_nest/funnels/bloc/dateTimeBloc/dateTimeBloc.dart';
import 'package:the_pet_nest/funnels/bloc/dateTimeBloc/dateTimeState.dart';
import 'package:the_pet_nest/funnels/bloc/funnelState.dart';
import 'package:the_pet_nest/funnels/bloc/packageBloc/packageBloc.dart';
import 'package:the_pet_nest/funnels/bloc/packageBloc/packageState.dart';
import 'package:the_pet_nest/funnels/bloc/paymentSelectionBloc/paymentSelectionBloc.dart';
import 'package:the_pet_nest/funnels/bloc/paymentSelectionBloc/paymentSelectionState.dart';
import 'package:the_pet_nest/funnels/interfaces/AddressSelectionInterface.dart';
import 'package:the_pet_nest/funnels/interfaces/BookingConfirmationInterface.dart';
import 'package:the_pet_nest/funnels/interfaces/bookingDetailReviewInterface.dart';
import 'package:the_pet_nest/funnels/interfaces/couponSelectionInterface.dart';
import 'package:the_pet_nest/funnels/interfaces/dateTimeSelectionInterface.dart';
import 'package:the_pet_nest/funnels/interfaces/packageSelectionInterface.dart';
import 'package:the_pet_nest/funnels/interfaces/paymentMethodSelectionInterface.dart';
import 'package:the_pet_nest/funnels/interfaces/petIssueSelectionInterface.dart';
import 'package:the_pet_nest/funnels/interfaces/petSelectionInterface.dart';
import 'package:the_pet_nest/funnels/model/couponseApiResponseModel.dart';
import 'package:the_pet_nest/funnels/model/packageDetailApiResponseModel.dart';
import 'package:the_pet_nest/funnels/screen/ScreenAddressSelection.dart';
import 'package:the_pet_nest/funnels/screen/ScreenIssueList.dart';
import 'package:the_pet_nest/funnels/screen/screenBookingConfirmation.dart';
import 'package:the_pet_nest/funnels/screen/screenCouponSelection.dart';
import 'package:the_pet_nest/funnels/screen/screenDateSelection.dart';
import 'package:the_pet_nest/funnels/screen/screenPackageSelection.dart';
import 'package:the_pet_nest/funnels/screen/screenPaymentMethod.dart';
import 'package:the_pet_nest/funnels/screen/screenPetSelection.dart';
import 'package:the_pet_nest/funnels/screen/screenReviewBookingDetail.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/enums.dart';
import 'package:the_pet_nest/profiles/bloc/petProfile/petProfileBloc.dart';
import 'package:the_pet_nest/profiles/bloc/petProfile/petProfileState.dart';
import 'package:the_pet_nest/profiles/model/getPetListModel.dart';
import 'package:the_pet_nest/utils/utils.dart';

class VetService extends StatelessWidget
    implements
        AddressSelectionInterface,
        PetSelectionInterface,
        PackageSelectionInterface,
        DateTimeSelectionInterface,
        BookingDetailReviewInterface,
        PaymentMethodSelectionInterface,
        CouponSelectionInterface,
        BookingConfirmationInterface,
        PetIssueSelection {
  const VetService({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // String
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => AddressBookBloc(initialState: AddressBookState())),
          BlocProvider(create: (_) => VetBloc(FunnelState())),
          BlocProvider(create: (_) => PetProfileBloc(PetProfileState())),
          BlocProvider(create: (_) => PackageBloc(PackageState())),
          BlocProvider(create: (_) => DateTimeBloc(DateTimeState())),
          BlocProvider(create: (_) => CouponBloc(CouponState())),
          BlocProvider(create: (_) => BookingBloc(BookingState())),
          BlocProvider(
              create: (_) => PaymentSelectionBloc(PaymentSelectionState()))
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<VetBloc, FunnelState>(listener: (blocContext, state) {
              if (state.closeThisFunnel) {
                Navigator.pop(context);
              }
              if (state.showError) {
                showSnackbar(context: blocContext, message: state.errorMessage);
              }
            }),
            BlocListener<CouponBloc, CouponState>(
                listener: (blocContext, state) {
              if (state.hasError) {
                showSnackbar(context: blocContext, message: state.errorMsg);
              } else if (state.isCouponApplied) {
                BlocProvider.of<VetBloc>(blocContext)
                    .applyDiscount(state.discountValue);
              }
            })
          ],
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: kAppBackgroundAltGray,
              leading: BlocBuilder<VetBloc, FunnelState>(
                builder: (blocContext, state) {
                  return IconButton(
                    onPressed: () {
                      BlocProvider.of<VetBloc>(blocContext).goBack();
                    },
                    icon: Icon(Icons.arrow_back),
                  );
                },
              ),
              title: BlocBuilder<VetBloc, FunnelState>(
                builder: (blocContext, state) {
                  switch (state.currentScreen) {
                    case FunnelScreens.SCREEN_BOOKING_CONFIRMED:
                      return Row(
                        children: [
                          SvgPicture.asset(
                              'assets/images/funnels/icon_booking_confirmed.svg'),
                          Text(
                            "Booking Confirmed",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                height: 1.5),
                          )
                        ],
                      );
                    case FunnelScreens.SCREEN_BOOKING_CANCELLED:
                      return Row(
                        children: [
                          SvgPicture.asset(
                              'assets/images/funnels/icon_booking_cancelled.svg'),
                          Text(
                            "Booking Cancelled",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                height: 1.5),
                          )
                        ],
                      );
                    case FunnelScreens.SCREEN_COUPONS_SELECTION:
                      return Text(
                        "Coupon",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            height: 1.5,
                            color: kAppIconColor),
                      );
                    default:
                      return Text("");
                  }
                },
              ),
            ),
            backgroundColor: kAppBackgroundAltGray,
            body: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                BlocBuilder<VetBloc, FunnelState>(
                    builder: (blocContext, state) {
                  late Widget body;
                  switch (state.currentScreen) {
                    case FunnelScreens.SCREEN_ADDRESS_SELECTION:
                      body = ScreenAddressSelection(onAddressSelection: this);
                      break;
                    case FunnelScreens.SCREEN_PET_SELECTION:
                      body = ScreenPetSelection(onPetSelected: this);
                      break;
                    case FunnelScreens.SCREEN_PACKAGE_SELECTION:
                      body = ScreenPackageSelection(
                        onPackageSelected: this,
                        petCategory: state.petCategory,
                        city: state.citySlug,
                        cityId: state.address!.cityId,
                        currentFunnel: FunnelType.VET_SERVICE,
                      );
                      break;
                    case FunnelScreens.SCREEN_REVIEW_BOOKING_DETAILS:
                      double _totalPrice = 0;
                      state.packageDetail!.forEach((element) {
                        _totalPrice += double.parse(element.price!);
                      });
                      body = ScreenReviewBookingDetail(
                          onBookingDetailReviewInterface: this,
                          totalPrice: _totalPrice,
                          petData: state.petData!,
                          packageDetail: state.packageDetail!,
                          currentFunnel: FunnelType.PET_TRAINING);
                      break;
                    case FunnelScreens.SCREEN_PAYMENT_METHOD:
                      double _totalPrice = 0;
                      state.packageDetail!.forEach((element) {
                        _totalPrice += double.parse(element.price!);
                      });
                      body = ScreenPaymentMethod(
                          onPaymentMethodSelected: this,
                          totalPrice: _totalPrice);
                      break;
                    case FunnelScreens.SCREEN_COUPONS_SELECTION:
                      double _totalPrice = 0;
                      state.packageDetail!.forEach((element) {
                        _totalPrice += double.parse(element.price!);
                      });
                      body = ScreenCouponSelection(
                        onCouponSelection: this,
                        totalPrice: _totalPrice,
                      );
                      break;
                    case FunnelScreens.SCREEN_DATE_TIME_SELECTION:
                      body = ScreenDateTimeSelection(
                        onDateTimeSelected: this,
                        cityId: state.address!.cityId,
                      );
                      break;
                    case FunnelScreens.SCREEN_BOOKING_CONFIRMED:
                      BlocProvider.of<BookingBloc>(blocContext)
                          .updateBookingData(state.bookingConfirmationData!);
                      body = ScreenBookingConfirmation(
                          onBookingConfirmation: this);
                      break;
                    case FunnelScreens.SCREEN_PET_ISSUE_SELECTION:
                      body = ScreenPetIssueList(onPetIssueSelection: this);
                      break;
                  }
                  return Expanded(
                    child: Column(
                      children: [
                        LinearProgressIndicator(
                          backgroundColor: kAppBackgroundAltGray,
                          color: kAppIconColor,
                          value: state.progressIndicator,
                        ),
                        body
                      ],
                    ),
                  );
                }),
                // Text(textTest)
              ],
            ),
          ),
        ));
  }

  @override
  void onAddressSelected(blocContext, Address? address) {
    BlocProvider.of<VetBloc>(blocContext).setAddress(address);
  }

  @override
  void onAddressSelectionComplete(blocContext) {
    BlocProvider.of<VetBloc>(blocContext).openPetIssueSelectionScreen();
  }

  @override
  void onNoteUpdated(blocContext, String note) {
    // TODO: implement onPetSelectionComplete
  }

  @override
  void onPetSelectionComplete(blocContext) {
    BlocProvider.of<VetBloc>(blocContext).openPackageSelectionScreen();
  }

  @override
  void petSelected(blocContext, CustomerPet petData) {
    BlocProvider.of<VetBloc>(blocContext).setPet(petData);
  }

  @override
  void onPackageSelectionComplete(blocContext) {
    BlocProvider.of<VetBloc>(blocContext).openBookingDetailsReviewScreen();
  }

  @override
  void packageSelected(blocContext, PackageDetailModel packageDetail) {
    BlocProvider.of<VetBloc>(blocContext).setPackage(packageDetail);
  }

  @override
  void onAddAnotherPetClicked(blocContext) {
    BlocProvider.of<VetBloc>(blocContext).addNewService();
    BlocProvider.of<PetProfileBloc>(blocContext).resetState();
    BlocProvider.of<PackageBloc>(blocContext).resetState();
  }

  @override
  void onBookingDetailReviewComplete(blocContext) {
    BlocProvider.of<VetBloc>(blocContext).openDateTimeSelectionScreen();
  }

  @override
  void onPaymentMethodChange(blocContext, PAYMENT_METHOD paymentMethod) {
    BlocProvider.of<VetBloc>(blocContext).setPayment(paymentMethod);
  }

  @override
  void onPaymentMethodSelectionComplete(blocContext) {
    BlocProvider.of<VetBloc>(blocContext).processBooking();
  }

  @override
  void dateSelected(blocContext, String date) {
    BlocProvider.of<VetBloc>(blocContext).setDateTime(date: date);
  }

  @override
  void timeSelected(blocContext, String time) {
    BlocProvider.of<VetBloc>(blocContext).setDateTime(time: time);
  }

  @override
  void onDateTimeSelectionComplete(blocContext) {
    BlocProvider.of<VetBloc>(blocContext).openPaymentMethodScreen();
  }

  @override
  void onCouponSelectionButtonClicked(blocContext) {
    BlocProvider.of<VetBloc>(blocContext).openCouponScreen();
  }

  @override
  void onCouponSelected(blocContext, CouponData couponData) {
    BlocProvider.of<VetBloc>(blocContext).couponSelected(couponData);
  }

  @override
  void onCouponSelectionCompleted(blocContext) {
    BlocProvider.of<VetBloc>(blocContext).openDateTimeSelectionScreen();
  }

  @override
  void onCancelBooking(blocContext) {
    // TODO: implement onCancelBooking
  }

  @override
  void onMakeCall(blocContext, String phoneNumber) {
    // TODO: implement onMakeCall
  }

  @override
  void onReschedule(blocContext) {
    // TODO: implement onReschedule
  }

  @override
  void onPetIssueSelected(blocContext, int category, String? text) {
    BlocProvider.of<VetBloc>(blocContext).setCategory(category, text);
    BlocProvider.of<VetBloc>(blocContext).openPetSelectionScreen();
  }
}
