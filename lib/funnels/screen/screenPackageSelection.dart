import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_pet_nest/config/sizeConfig.dart';
import 'package:the_pet_nest/funnels/component/cardDatePicker.dart';
import 'package:the_pet_nest/funnels/component/cardPackageInfo.dart';
import 'package:the_pet_nest/funnels/component/timeSelectionCard.dart';
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
  String dateSelected = '';

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
                    style: kFunnelScreenHeadingTextStyle,
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
                                  DateTime.now().month + 1),
                              cancelText: 'Close',
                              confirmText: 'Submit')
                          .then((data) {
                        hideDatePicker();
                        setState(() {
                          dateSelected = DateFormat('dd/MM/yy').format(data!);
                        });
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      padding: EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            dateSelected.isNotEmpty ? dateSelected : 'dd/mm/yy',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                height: 1.5,
                                color: dateSelected.isNotEmpty
                                    ? Colors.black87
                                    : Colors.grey),
                          ),
                          Icon(
                            Icons.calendar_today_outlined,
                            color: kAppIconColor,
                          )
                        ],
                      ),
                    ),
                  ),
                  Text(
                    'Select Time',
                    style: TextStyle(
                        height: 1.5, fontWeight: FontWeight.w400, fontSize: 16),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 3.5,
                          mainAxisSpacing: 11,
                          crossAxisSpacing: 11),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return TimeSelectionCard(
                          selected: false,
                          available: true,
                        );
                      }),
                  SizedBox(
                    height: 59,
                  ),
                  TextButton(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      width: double.infinity,
                      decoration: kActiveButtonContainerStyle,
                      child: Text(
                        'Next',
                        textAlign: TextAlign.center,
                        style: kActiveButtonTextStyle,
                      ),
                    ),
                    onPressed: () => screenPackageSelectionResponse(dataHolder),
                  ),
                  SizedBox(
                    height: 69,
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
