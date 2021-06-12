import 'package:flutter/material.dart';
import 'package:the_pet_nest/dashboard/component/addPetPopup/component/addedPetCard.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/styles.dart';
import 'package:the_pet_nest/konstants/values.dart';
import 'package:the_pet_nest/profiles/petProfile/model/petData.dart';

class AddedPetModal extends StatefulWidget {
  const AddedPetModal({Key? key, required this.addedPetScreenResponse})
      : super(key: key);

  final Function addedPetScreenResponse;

  @override
  _AddedPetModalState createState() =>
      _AddedPetModalState(addedPetScreenResponse);
}

class _AddedPetModalState extends State<AddedPetModal> {
  final Function addedPetScreenResponse;
  String gender = kPetGenderNone;
  String aggression = kPetAggressionMedium;
  bool vaccinated = false;

  _AddedPetModalState(this.addedPetScreenResponse);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20.5),
        width: double.infinity,
        color: Colors.transparent,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            height: 12.76,
          ),
          Container(
            height: 2,
            width: 38.34,
            decoration: BoxDecoration(
                color: kAppIconColor, borderRadius: BorderRadius.circular(1)),
          ),
          SizedBox(
            height: 14,
          ),
          Container(
            height: 150,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: PetData.length,
                itemBuilder: (context, index) {
                  return AddedPetCard(
                    name: PetData[index]['name'],
                    image: PetData[index]['image'],
                    breed: PetData[index]['breed'],
                  );
                }),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
                color: kActiveButtonColor,
                borderRadius: BorderRadius.all(Radius.circular(51)),
                boxShadow: [kContainerBoxShadow]),
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
            child: TextButton(
              onPressed: () => addedPetScreenResponse(kPopupSelectPetType),
              child: Text(
                'Add another pet',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w200,
                    height: 1.5,
                    color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            height: 110,
          ),
          Container(
            width: double.infinity,
            decoration: kActiveButtonContainerStyle,
            padding: EdgeInsets.symmetric(vertical: 10),
            child: TextButton(
              onPressed: () {},
              child: Text(
                'Submit',
                style: kActiveButtonTextStyle,
              ),
            ),
          )
        ]));
  }
}
