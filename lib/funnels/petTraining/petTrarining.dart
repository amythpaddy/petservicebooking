import 'package:flutter/material.dart';
import 'package:the_pet_nest/funnels/component/AppBarComponent.dart';
import 'package:the_pet_nest/funnels/petTraining/model/petTrainingFunnelDataHolder.dart';
import 'package:the_pet_nest/funnels/screen/ScreenAddressSelection.dart';
import 'package:the_pet_nest/funnels/screen/screenPackageSelection.dart';
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
  STEP_BOOKING_DETAILS,
  STEP_SELECT_DATE_TIME,
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
      _progressValue = 2 / _totalScreens;
    });
  }

  void screenPetSelectionResponse(PetTrainingFunnelDataHolder dataHolder) {
    this.dataHolder = dataHolder;
    setState(() {
      currentStep = PetTrainingStep.STEP_CHOOSE_PACKAGE;
      _progressValue = 3 / _totalScreens;
    });
  }

  void screenPackageSelectionResponse(PetTrainingFunnelDataHolder dataHolder) {
    this.dataHolder = dataHolder;
    setState(() {
      currentStep = PetTrainingStep.STEP_SELECT_PET;
      _progressValue = 4 / _totalScreens;
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
    }
    return Scaffold(
      appBar: AppBarComponent(),
      backgroundColor: kAppBackgroundAltGray,
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          LinearProgressIndicator(
            backgroundColor: kAppBackgroundAltGray,
            color: kAppIconColor,
            value: _progressValue,
          ),
          body
        ],
      ),
    );
  }
}
