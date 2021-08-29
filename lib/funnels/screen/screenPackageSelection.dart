import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:the_pet_nest/funnels/bloc/packageBloc/packageBloc.dart';
import 'package:the_pet_nest/funnels/bloc/packageBloc/packageState.dart';
import 'package:the_pet_nest/funnels/component/cardPackageInfo.dart';
import 'package:the_pet_nest/funnels/component/packageTypeSelector.dart';
import 'package:the_pet_nest/funnels/interfaces/packageSelectionInterface.dart';
import 'package:the_pet_nest/konstants/enums.dart';
import 'package:the_pet_nest/konstants/styles.dart';

class ScreenPackageSelection extends StatelessWidget {
  final PackageSelectionInterface onPackageSelected;
  final PetCategory petCategory;
  final String city;
  final FunnelType currentFunnel;
  const ScreenPackageSelection(
      {Key? key,
      required this.onPackageSelected,
      required this.petCategory,
      required this.city,
      required this.currentFunnel})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PackageBloc>(context)
        .getPackageDetail(city, petCategory, currentFunnel);
    return SingleChildScrollView(
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
            if (currentFunnel != FunnelType.PET_GROOMING)
              Center(
                child: Container(
                  width: 228,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(68),
                      boxShadow: [kContainerBoxShadow]),
                  child: BlocBuilder<PackageBloc, PackageState>(
                    builder: (blocContext, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PackageTypeSelector(
                              boxDecoration:
                                  state.packageType == PackageType.INHOME
                                      ? kTabbedHeadingBlue
                                      : null,
                              onPressed:
                                  BlocProvider.of<PackageBloc>(blocContext)
                                      .getInHomePackage,
                              title: 'In-Home',
                              textStyle: state.packageType == PackageType.INHOME
                                  ? kActiveButtonTextStyle
                                  : kInactiveButtonTextStyle),
                          PackageTypeSelector(
                              boxDecoration:
                                  state.packageType == PackageType.ONLINE
                                      ? kTabbedHeadingBlue
                                      : null,
                              onPressed:
                                  BlocProvider.of<PackageBloc>(blocContext)
                                      .getOnlinePackage,
                              title: 'Online',
                              textStyle: state.packageType == PackageType.INHOME
                                  ? kActiveButtonTextStyle
                                  : kInactiveButtonTextStyle),
                        ],
                      );
                    },
                  ),
                ),
              ),
            SizedBox(
              height: 14.43,
            ),
            BlocBuilder<PackageBloc, PackageState>(
                builder: (blocContext, state) {
              if (state.loadingPackagesData) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300] ?? Colors.grey,
                  highlightColor: Colors.white,
                  child: Container(
                    width: 325.0,
                    height: 169.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.grey),
                  ),
                );
              } else {
                return Container(
                  height: 169,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.packages!.data!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.all(0),
                            ),
                            onPressed: () {
                              onPackageSelected.packageSelected(
                                  blocContext, state.packages!.data![index]);
                              BlocProvider.of<PackageBloc>(blocContext)
                                  .updatePackageSelectedIndex(index);
                            },
                            child: CardPackageInfo(
                              currentFunnel: currentFunnel,
                              name: state.packages!.data![index].name!,
                              details: state.packages!.data![index].detail!,
                              price: state.packages!.data![index].price!,
                              selected: state.selectedPackageIndex == index,
                            ),
                          )),
                );
              }
            }),
            SizedBox(
              height: 350,
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
              onPressed: () =>
                  onPackageSelected.onPackageSelectionComplete(context),
            ),
          ],
        ),
      ),
    );
  }
}
