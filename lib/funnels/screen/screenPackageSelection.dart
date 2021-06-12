import 'package:flutter/material.dart';
import 'package:the_pet_nest/config/sizeConfig.dart';
import 'package:the_pet_nest/funnels/component/cardDatePicker.dart';
import 'package:the_pet_nest/funnels/component/cardPackageInfo.dart';
import 'package:the_pet_nest/funnels/petTraining/model/petTrainingFunnelDataHolder.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/styles.dart';

class ScreenPackageSelection extends StatefulWidget {
  const ScreenPackageSelection(
      {Key? key,
      required this.dataHolder,
      required this.screenPackageSelectionResponse})
      : super(key: key);
  final PetTrainingFunnelDataHolder dataHolder;
  final Function screenPackageSelectionResponse;

  @override
  _ScreenPackageSelectionState createState() =>
      _ScreenPackageSelectionState(dataHolder, screenPackageSelectionResponse);
}

enum PackageType { ONLINE, INHOME }

class _ScreenPackageSelectionState extends State<ScreenPackageSelection> {
  final PetTrainingFunnelDataHolder dataHolder;
  final Function screenPackageSelectionResponse;
  bool showDatePicker = false;

  PackageType _packageType = PackageType.INHOME;

  _ScreenPackageSelectionState(
      this.dataHolder, this.screenPackageSelectionResponse);

  void getInhomePackages() {
    setState(() {
      _packageType = PackageType.INHOME;
    });
  }

  void getOnlinePackages() {
    setState(() {
      _packageType = PackageType.ONLINE;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 17.37,
                  ),
                  Text(
                    'Choose a service package',
                    style: TextStyle(
                        color: kAppIconColor,
                        fontSize: 24,
                        height: 1.5,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 16.19,
                  ),
                  Center(
                    child: Container(
                      width: 228,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(68),
                          boxShadow: [kContainerBoxShadow]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: 114,
                              decoration: _packageType == PackageType.INHOME
                                  ? kTabbedHeadingBlue
                                  : null,
                              child: TextButton(
                                  onPressed: getInhomePackages,
                                  child: Text(
                                    'In-Home',
                                    style: _packageType == PackageType.INHOME
                                        ? kActiveButtonTextStyle
                                        : kInactiveButtonTextStyle,
                                  ))),
                          Container(
                              width: 114,
                              decoration: _packageType == PackageType.ONLINE
                                  ? kTabbedHeadingBlue
                                  : null,
                              child: TextButton(
                                  onPressed: getOnlinePackages,
                                  child: Text(
                                    'Online',
                                    style: _packageType == PackageType.ONLINE
                                        ? kActiveButtonTextStyle
                                        : kInactiveButtonTextStyle,
                                  )))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 14.43,
                  ),
                  CardPackageInfo(),
                  SizedBox(
                    height: 14,
                  ),
                  Text(
                    'Select Date',
                    style: TextStyle(
                        height: 1.5, fontWeight: FontWeight.w400, fontSize: 16),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        showDatePicker = true;
                      });
                      showCustomDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(DateTime.now().year,
                                  DateTime.now().month + 1))
                          .then((data) {
                        hideDatePicker();
                        print(data);
                      });
                    },
                    child: Text('Select Date'),
                  )
                ],
              ),
            ),
          ),
          if (showDatePicker)
            Container(
              width: SizeConfig.blockSizeHorizontal! * 100,
              height: SizeConfig.blockSizeVertical! * 100,
              color: Color(0x77000000),
            ),
        ],
      ),
    );
  }

  hideDatePicker() {
    setState(() {
      showDatePicker = false;
    });
  }
}
