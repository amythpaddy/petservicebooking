import 'package:flutter/material.dart';
import 'package:the_pet_nest/funnels/petTraining/model/petTrainingFunnelDataHolder.dart';

class ScreenBookingConfirmation extends StatelessWidget {
  const ScreenBookingConfirmation(
      {Key? key,
      required this.screenBookingConfirmationResponse,
      required this.dataHolder})
      : super(key: key);
  final Function screenBookingConfirmationResponse;
  final PetTrainingFunnelDataHolder dataHolder;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
