import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:the_pet_nest/config/sizeConfig.dart';
import 'package:the_pet_nest/funnels/bloc/packageBloc/packageBloc.dart';
import 'package:the_pet_nest/funnels/bloc/packageBloc/packageState.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/enums.dart';
import 'package:the_pet_nest/konstants/styles.dart';

class CardPackageInfo extends StatelessWidget {
  CardPackageInfo(
      {Key? key,
      required this.currentFunnel,
      required this.name,
      required this.details,
      required this.price,
      required this.selected,
      this.expand = false,
      this.valueAdded = "",
      this.requirements = ""})
      : super(key: key) {
    List<String> detailsList = this.details.split(",");
    detailsList.forEach((element) {
      detailsPointer.add(
        RichText(
          text: bulletText(element),
          softWrap: true,
        ),
      );
    });
  }
  final FunnelType currentFunnel;
  final String name;
  final String details;
  final String price;
  final List<Widget> detailsPointer = [];
  final bool selected;
  final String valueAdded;
  final String requirements;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      width: SizeConfig.blockSizeHorizontal * 84,
      padding: EdgeInsets.only(left: 16.81),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: selected ? kTextColorBlue : kAppBackgroundAltGray,
              width: 2),
          boxShadow: [kContainerBoxShadow],
          color: Colors.white),
      child: Column(
        mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Text(
                        this.name,
                        style: TextStyle(
                            height: 1.5,
                            fontWeight: FontWeight.w700,
                            fontSize: 16),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Visibility(
                        visible: currentFunnel == FunnelType.PET_GROOMING,
                        child: detailsPointer[0]),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 0, left: 10, right: 10),
                padding: EdgeInsets.symmetric(horizontal: 9.96, vertical: 10),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/images/funnels/package_cost_bg.png'),
                        fit: BoxFit.fill)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Per Session',
                      style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                    Text(
                      '\u{20B9} $price',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Colors.white),
                    )
                  ],
                ),
              )
            ],
          ),
          currentFunnel == FunnelType.PET_TRAINING
              ? Html(
                  data: details,
                  style: {
                    "body": Style(
                        color: kTextColorBlue,
                        fontSize: FontSize.medium,
                        fontWeight: FontWeight.w300)
                  },
                )
              : Wrap(
                  children: currentFunnel == FunnelType.PET_GROOMING
                      ? detailsPointer.sublist(1, detailsPointer.length)
                      : detailsPointer,
                  direction: Axis.horizontal,
                ),
          SizedBox(
            height: 10,
          ),
          Visibility(
            visible: currentFunnel == FunnelType.PET_TRAINING,
            child: BlocBuilder<PackageBloc, PackageState>(
                builder: (blocContext, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(),
                  TextButton(
                      onPressed: state.valueAddedExpanded
                          ? BlocProvider.of<PackageBloc>(blocContext)
                              .closeValueAdded
                          : BlocProvider.of<PackageBloc>(blocContext)
                              .expandValueAdded,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Value Added',
                            style: TextStyle(color: kTextColorBlue),
                          ),
                          Icon(state.valueAddedExpanded
                              ? Icons.arrow_drop_down_rounded
                              : Icons.arrow_right_rounded)
                        ],
                      )),
                  Visibility(
                    child: Text(
                      valueAdded,
                      style: TextStyle(
                          color: kTextColorBlue,
                          fontWeight: FontWeight.w300,
                          fontSize: 10,
                          height: 2.7),
                    ),
                    visible: state.valueAddedExpanded,
                  ),
                  TextButton(
                      onPressed: state.requirementsExpanded
                          ? BlocProvider.of<PackageBloc>(blocContext)
                              .closeRequirements
                          : BlocProvider.of<PackageBloc>(blocContext)
                              .expandRequirements,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Requirements',
                            style: TextStyle(color: kTextColorBlue),
                          ),
                          Icon(state.requirementsExpanded
                              ? Icons.arrow_drop_down_rounded
                              : Icons.arrow_right_rounded)
                        ],
                      )),
                  Visibility(
                    child: Text(
                      requirements,
                      style: TextStyle(
                          color: kTextColorBlue,
                          fontWeight: FontWeight.w300,
                          fontSize: 10,
                          height: 2.7),
                    ),
                    visible: state.requirementsExpanded,
                  )
                ],
              );
            }),
          )
        ],
      ),
    );
  }

  TextSpan bulletText(String text) {
    return TextSpan(
      children: [
        TextSpan(
            text: '\u2022 ',
            style: TextStyle(color: kAppIconColor, fontSize: 16)),
        TextSpan(
            text: '$text  ',
            style: TextStyle(
                color: kTextColorBlue,
                fontWeight: FontWeight.w300,
                fontSize: 12,
                height: 2.7))
      ],
    );
  }
}
