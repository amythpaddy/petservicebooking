import 'package:flutter/material.dart';
import 'package:the_pet_nest/config/sizeConfig.dart';
import 'package:the_pet_nest/funnels/component/selectLocationComponent.dart';
import 'package:the_pet_nest/funnels/petTraining/model/petTrainingFunnelDataHolder.dart';
import 'package:the_pet_nest/funnels/petTraining/model/savedAddressModel.dart';
import 'package:the_pet_nest/konstants/styles.dart';

import '../component/addLocationComponent.dart';

class ScreenAddressSelection extends StatefulWidget {
  const ScreenAddressSelection(
      {Key? key,
      required this.screenAddressSelectionResponse,
      required this.dataHolder})
      : super(key: key);
  final Function screenAddressSelectionResponse;
  final PetTrainingFunnelDataHolder dataHolder;

  @override
  _ScreenAddressSelectionState createState() =>
      _ScreenAddressSelectionState(dataHolder, screenAddressSelectionResponse);
}

class _ScreenAddressSelectionState extends State<ScreenAddressSelection> {
  final Function screenAddressSelectionResponse;
  final PetTrainingFunnelDataHolder dataHolder;
  int selectedAddressIndex = -1;
  String? _chosenValue;

  _ScreenAddressSelectionState(
      this.dataHolder, this.screenAddressSelectionResponse);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 18.46),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 60.89,
            ),
            Text(
              'Select City',
              style: TextStyle(
                  fontWeight: FontWeight.w400, fontSize: 16, height: 1.5),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal! * 90,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), color: Colors.white),
              child: DropdownButton<String>(
                value: _chosenValue,
                underline: SizedBox(),
                style: TextStyle(color: Colors.black),
                items: <String>[
                  'Delhi',
                  'Gurgaon',
                  'Mumbai',
                  'Ghaziabad',
                  'Noida',
                  'Kolkata'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Container(
                      padding: EdgeInsets.only(left: 17),
                      child: Text(
                        value,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                    ),
                  );
                }).toList(),
                hint: Container(
                  padding: EdgeInsets.only(left: 17),
                  width: SizeConfig.blockSizeHorizontal! * 80,
                  child: Text(
                    "Choose your city",
                    style: TextStyle(
                        color: Colors.black26,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                onChanged: (value) => {
                  setState(() {
                    _chosenValue = value!;
                  })
                },
              ),
            ),
            SizedBox(
              height: 27.1,
            ),
            Text(
              'Address',
              style: TextStyle(
                  fontWeight: FontWeight.w400, fontSize: 16, height: 1.5),
            ),
            SizedBox(
              height: 8,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: SavedAddress.length,
                  itemBuilder: (context, index) => TextButton(
                      onPressed: () {
                        setState(() {
                          selectedAddressIndex = index;
                        });
                      },
                      child: SelectLocationComponent(
                        city: SavedAddress[index]['city']!,
                        address: SavedAddress[index]['address']!,
                        selected: index == selectedAddressIndex,
                      ))),
            ),
            SizedBox(
              height: 8,
            ),
            AddLocationComponent(),
            SizedBox(
              height: 8,
            ),
            TextButton(
              child: Container(
                  alignment: Alignment.center,
                  decoration: kActiveButtonContainerStyle,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Next',
                    style: kActiveButtonTextStyle,
                  )),
              onPressed: () {
                dataHolder.location =
                    SavedAddress[selectedAddressIndex]['address']!;
                screenAddressSelectionResponse(dataHolder);
              },
            ),
            SizedBox(
              height: 63,
            )
          ],
        ),
      ),
    );
  }
}
