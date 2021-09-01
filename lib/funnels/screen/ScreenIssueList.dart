import 'package:flutter/material.dart';
import 'package:the_pet_nest/funnels/component/petIssueComponent.dart';
import 'package:the_pet_nest/funnels/interfaces/petIssueSelectionInterface.dart';
import 'package:the_pet_nest/konstants/colors.dart';

class ScreenPetIssueList extends StatelessWidget {
  const ScreenPetIssueList({Key? key, required this.onPetIssueSelection})
      : super(key: key);
  final PetIssueSelection onPetIssueSelection;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(18),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'What seems to be the issue?',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                  height: 1.5,
                  color: kAppIconColor),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Select all that apply.',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  height: 1.5,
                  color: kTextColorBlue),
            ),
            SizedBox(
              height: 14,
            ),
            TextButton(
              onPressed: () =>
                  onPetIssueSelection.onPetIssueSelected(context, 1, ""),
              child: PetIssueComponent(
                  value: 'General Medical Question',
                  icon:
                      'assets/images/funnels/vet_service/icon_general_medical.svg'),
            ),
            TextButton(
              onPressed: () =>
                  onPetIssueSelection.onPetIssueSelected(context, 1, ""),
              child: PetIssueComponent(
                  value: 'Diarrhea or bowel issues',
                  icon: 'assets/images/funnels/vet_service/icon_diarrhea.svg'),
            ),
            TextButton(
              onPressed: () =>
                  onPetIssueSelection.onPetIssueSelected(context, 1, ""),
              child: PetIssueComponent(
                  value: 'Ear infection',
                  icon:
                      'assets/images/funnels/vet_service/icon_ear_infection.svg'),
            ),
            TextButton(
              onPressed: () =>
                  onPetIssueSelection.onPetIssueSelected(context, 1, ""),
              child: PetIssueComponent(
                  value: 'Loss of appetite',
                  icon:
                      'assets/images/funnels/vet_service/icon_loss_of_appetite.svg'),
            ),
            TextButton(
              onPressed: () =>
                  onPetIssueSelection.onPetIssueSelected(context, 1, ""),
              child: PetIssueComponent(
                  value: 'Throwing up',
                  icon:
                      'assets/images/funnels/vet_service/icon_throwing_up.svg'),
            ),
            TextButton(
              onPressed: () =>
                  onPetIssueSelection.onPetIssueSelected(context, 1, ""),
              child: PetIssueComponent(
                  value: 'Behavioral problems',
                  icon:
                      'assets/images/funnels/vet_service/icon_behavioral.svg'),
            ),
            TextButton(
              onPressed: () =>
                  onPetIssueSelection.onPetIssueSelected(context, 1, ""),
              child: PetIssueComponent(
                  value: 'Skin rash or allergy',
                  icon: 'assets/images/funnels/vet_service/icon_hair.svg'),
            ),
            TextButton(
              onPressed: () =>
                  onPetIssueSelection.onPetIssueSelected(context, 1, ""),
              child: PetIssueComponent(
                  value: 'Injury',
                  icon: 'assets/images/funnels/vet_service/icon_injury.svg'),
            ),
            TextButton(
              onPressed: () =>
                  onPetIssueSelection.onPetIssueSelected(context, 1, ""),
              child: PetIssueComponent(
                  value: 'Dental Issues',
                  icon: 'assets/images/funnels/vet_service/icon_dental.svg'),
            ),
            TextButton(
              onPressed: () =>
                  onPetIssueSelection.onPetIssueSelected(context, 1, ""),
              child: PetIssueComponent(
                  value: 'Other',
                  icon: 'assets/images/funnels/vet_service/icon_other.svg',
                  color: kAppIconColor),
            ),
          ],
        ),
      ),
    );
  }
}
