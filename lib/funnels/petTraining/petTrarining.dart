import 'package:flutter/material.dart';
import 'package:the_pet_nest/funnels/petTraining/model/petTrainingFunnelDataHolder.dart';
import 'package:the_pet_nest/funnels/screen/ScreenAddressSelection.dart';
import 'package:the_pet_nest/funnels/screen/screenBookingDetail.dart';
import 'package:the_pet_nest/funnels/screen/screenPackageSelection.dart';
import 'package:the_pet_nest/funnels/screen/screenPaymentMethod.dart';
import 'package:the_pet_nest/funnels/screen/screenPetSelection.dart';
import 'package:the_pet_nest/konstants/colors.dart';

class PetTrainingService extends StatefulWidget {
  const PetTrainingService({Key? key}) : super(key: key);

  @override
  _PetTrainingServiceState createState() => _PetTrainingServiceState();
}

enum PetTrainingStep {
  STEP_SELECT_LOCATION,
  STEP_SELECT_PET,
  STEP_CHOOSE_PACKAGE,
  STEP_SELECT_BOOKING_DETAILS,
  STEP_SELECT_DATE_TIME,
  STEP_PAYMENT_METHOD,
  STEP_BOOKING_CONFIRMED,
  STEP_BOOKING_CANCELLED,
  STEP_SHOW_BOOKING_DETAILS
}

class _PetTrainingServiceState extends State<PetTrainingService> {
  PetTrainingStep currentStep = PetTrainingStep.STEP_SELECT_LOCATION;
  PetTrainingFunnelDataHolder dataHolder = PetTrainingFunnelDataHolder();
  late Widget body;

  double _progressValue = .25;
  int _totalScreens = 7;

  void screenAddressSelectionResponse(PetTrainingFunnelDataHolder dataHolder) {
    this.dataHolder = dataHolder;
    setState(() {
      currentStep = PetTrainingStep.STEP_SELECT_PET;
      _progressValue = 2;
    });
  }

  void screenPetSelectionResponse(PetTrainingFunnelDataHolder dataHolder) {
    this.dataHolder = dataHolder;
    setState(() {
      currentStep = PetTrainingStep.STEP_CHOOSE_PACKAGE;
      _progressValue = 3;
    });
  }

  void screenPackageSelectionResponse(PetTrainingFunnelDataHolder dataHolder) {
    this.dataHolder = dataHolder;
    setState(() {
      currentStep = PetTrainingStep.STEP_SELECT_BOOKING_DETAILS;
      _progressValue = 4;
    });
  }

  void screenBookingDetailResponse(PetTrainingFunnelDataHolder dataHolder) {
    this.dataHolder = dataHolder;
    setState(() {
      currentStep = PetTrainingStep.STEP_PAYMENT_METHOD;
      _progressValue = 5;
    });
  }

  void screenPaymentMethodResponse(PetTrainingFunnelDataHolder dataHolder) {
    this.dataHolder = dataHolder;
    setState(() {
      currentStep = PetTrainingStep.STEP_BOOKING_CONFIRMED;
      _progressValue = 6;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (currentStep) {
      case PetTrainingStep.STEP_SELECT_LOCATION:
        body = ScreenAddressSelection(
            dataHolder: dataHolder,
            screenAddressSelectionResponse: screenAddressSelectionResponse);
        break;
      case PetTrainingStep.STEP_SELECT_PET:
        body = ScreenPetSelection(
          screenPetSelectionResponse: screenPetSelectionResponse,
          dataHolder: dataHolder,
        );
        break;
      case PetTrainingStep.STEP_CHOOSE_PACKAGE:
        body = ScreenPackageSelection(
          dataHolder: dataHolder,
          screenPackageSelectionResponse: screenPackageSelectionResponse,
        );
        break;
      case PetTrainingStep.STEP_SELECT_BOOKING_DETAILS:
        body = ScreenBookingDetail(
          dataHolder: dataHolder,
          screenBookingDetailResponse: screenBookingDetailResponse,
        );
        break;
      case PetTrainingStep.STEP_PAYMENT_METHOD:
        body = ScreenPaymentMethod(
            screenPaymentMethodResponse: screenPaymentMethodResponse,
            dataHolder: dataHolder);
        break;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAppBackgroundAltGray,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            switch (currentStep) {
              case PetTrainingStep.STEP_SELECT_LOCATION:
              case PetTrainingStep.STEP_BOOKING_CANCELLED:
              case PetTrainingStep.STEP_BOOKING_CONFIRMED:
              case PetTrainingStep.STEP_SHOW_BOOKING_DETAILS:
                Navigator.pop(context);
                break;
              case PetTrainingStep.STEP_SELECT_PET:
                setState(() {
                  currentStep = PetTrainingStep.STEP_SELECT_LOCATION;
                  _progressValue = 1;
                });
                break;
              case PetTrainingStep.STEP_CHOOSE_PACKAGE:
                setState(() {
                  currentStep = PetTrainingStep.STEP_SELECT_PET;
                  _progressValue = 2;
                });
                break;
              case PetTrainingStep.STEP_SELECT_BOOKING_DETAILS:
                setState(() {
                  currentStep = PetTrainingStep.STEP_CHOOSE_PACKAGE;
                  _progressValue = 3;
                });
                break;
              case PetTrainingStep.STEP_PAYMENT_METHOD:
                setState(() {
                  currentStep = PetTrainingStep.STEP_SELECT_BOOKING_DETAILS;
                  _progressValue = 4;
                });
                break;
            }
          },
        ),
      ),
      backgroundColor: kAppBackgroundAltGray,
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          LinearProgressIndicator(
            backgroundColor: kAppBackgroundAltGray,
            color: kAppIconColor,
            value: _progressValue / _totalScreens,
          ),
          body
        ],
      ),
    );
  }
}
