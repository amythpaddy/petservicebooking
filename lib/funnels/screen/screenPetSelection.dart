import 'package:flutter/material.dart';
import 'package:the_pet_nest/funnels/component/selectAddedPetComponent.dart';
import 'package:the_pet_nest/funnels/petTraining/model/petTrainingFunnelDataHolder.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/styles.dart';
import 'package:the_pet_nest/profiles/petProfile/model/petData.dart';

class ScreenPetSelection extends StatefulWidget {
  const ScreenPetSelection(
      {Key? key,
      required this.screenPetSelectionResponse,
      required this.dataHolder})
      : super(key: key);
  final Function screenPetSelectionResponse;
  final PetTrainingFunnelDataHolder dataHolder;

  @override
  _ScreenPetSelectionState createState() =>
      _ScreenPetSelectionState(screenPetSelectionResponse, dataHolder);
}

class _ScreenPetSelectionState extends State<ScreenPetSelection> {
  final Function screenPetSelectionResponse;
  final PetTrainingFunnelDataHolder dataHolder;

  int _selectedPetIndex = -1;

  _ScreenPetSelectionState(this.screenPetSelectionResponse, this.dataHolder);
  @override
  Widget build(BuildContext context) {
    return Container(
        color: kAppBackgroundAltGray,
        margin: EdgeInsets.symmetric(horizontal: 18.46),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 27.37,
          ),
          Text(
            'Who are we helping?',
            style: kFunnelScreenHeadingTextStyle,
          ),
          SizedBox(
            height: 33.62,
          ),
          Container(
            height: 150,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: PetData.length,
                itemBuilder: (context, index) {
                  return TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedPetIndex = index;
                      });
                    },
                    child: SelectAddedPetCard(
                      name: PetData[index]['name'],
                      image: PetData[index]['image'],
                      breed: PetData[index]['breed'],
                      selected: index == _selectedPetIndex,
                    ),
                  );
                }),
          ),
          SizedBox(
            height: 47.14,
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                  color: kActiveButtonColor,
                  borderRadius: BorderRadius.all(Radius.circular(51)),
                  boxShadow: [kContainerBoxShadow]),
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
              child: TextButton(
                onPressed: () {},
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
          ),
          SizedBox(
            height: 48.37,
          ),
          Text.rich(TextSpan(children: [
            TextSpan(
                text: 'Additional Note ',
                style: TextStyle(
                    fontWeight: FontWeight.w400, fontSize: 16, height: 1.5)),
            TextSpan(
                text: ' (Optional)',
                style: TextStyle(
                    fontWeight: FontWeight.w400, fontSize: 10, height: 1.5))
          ])),
          SizedBox(
            height: 7.11,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [kContainerBoxShadow]),
            height: 84,
            child: TextField(
              minLines: 2,
              maxLines: 10,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                  hintText: 'Write a note for Groomer',
                  border: InputBorder.none,
                  fillColor: Colors.white),
            ),
          ),
          SizedBox(
            height: 130.82,
          ),
          TextButton(
            onPressed: () {
              screenPetSelectionResponse(dataHolder);
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: kActiveButtonContainerStyle,
              child: Text(
                'Next',
                textAlign: TextAlign.center,
                style: kActiveButtonTextStyle,
              ),
            ),
          )
        ]));
  }
}
