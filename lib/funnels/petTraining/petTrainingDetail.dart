import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:the_pet_nest/bookings/components/noRecentBooking.dart';
import 'package:the_pet_nest/config/sizeConfig.dart';
import 'package:the_pet_nest/funnels/bloc/packageBloc/packageBloc.dart';
import 'package:the_pet_nest/funnels/bloc/packageBloc/packageState.dart';
import 'package:the_pet_nest/funnels/component/cardPackageInfo.dart';
import 'package:the_pet_nest/funnels/component/packageTypeSelector.dart';
import 'package:the_pet_nest/funnels/petTraining/component/whyDogTrainingComponent.dart';
import 'package:the_pet_nest/home/bloc/homeBloc.dart';
import 'package:the_pet_nest/home/bloc/homeState.dart';
import 'package:the_pet_nest/home/component/petParentReviewCard.dart';
import 'package:the_pet_nest/home/component/petServicesDisplay.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/enums.dart';
import 'package:the_pet_nest/konstants/paths.dart';
import 'package:the_pet_nest/konstants/styles.dart';
import 'package:the_pet_nest/petHero/components/petHeroForDetailPage.dart';

class PetTrainingDetail extends StatelessWidget {
  PetTrainingDetail({Key? key}) : super(key: key);
  final List<Color> _gradientColor = [
    Color.fromARGB(0, 35, 44, 99),
    Color.fromARGB(189, 35, 44, 99),
    Color.fromARGB(255, 35, 44, 99)
  ];
  final List<double> _gradientStop = [0, .5, .8];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PackageBloc(PackageState())),
        BlocProvider(create: (_) => HomeBloc(HomeState())),
      ],
      child: Scaffold(
        backgroundColor: kAppBackgroundAltGray,
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: Stack(
                        children: [
                          Image.asset(
                              'assets/images/funnels/pet_training/pet_training_hero.png'),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              width: SizeConfig.screenWidth,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: _gradientColor,
                                      stops: _gradientStop,
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 74,
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                        padding: EdgeInsets.all(0)),
                                    onPressed: () => Navigator.pushNamed(
                                        context, kNavigationPetTrainingFunnel),
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: kActiveButtonContainerStyle,
                                      child: Text(
                                        'Book a Demo Session',
                                        style: kActiveButtonTextStyle,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 14.55,
                                  ),
                                  Text(
                                    'In - Home Dog Training ',
                                    style: TextStyle(color: Color(0xFFE5E5E5)),
                                  ),
                                  SizedBox(
                                    height: 21,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                              top: 21,
                              left: 23,
                              child: TextButton(
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                                onPressed: () => Navigator.pop(context),
                              ))
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 12.8),
                      padding: EdgeInsets.all(21),
                      color: kAppBackgroundColor,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Dog Training',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                height: 1.5,
                                color: kTextColorBlue),
                          ),
                          Text(
                            'Why it is so important?',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                height: 1.5,
                                color: kTextColorBlue),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: WhyDogTrainingComponent(
                                    image:
                                        'assets/images/funnels/pet_training/management_techniques.svg',
                                    heading: 'Management Techniques',
                                    detail:
                                        'We give you the tools to set your family to be successful.'),
                              ),
                              SizedBox(
                                width: 13,
                              ),
                              Expanded(
                                child: WhyDogTrainingComponent(
                                    image:
                                        'assets/images/funnels/pet_training/strengten_bond.svg',
                                    heading: 'Strengthen Bond',
                                    detail:
                                        'We help you bridge the gap between you and your dog.'),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 19,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: WhyDogTrainingComponent(
                                    image:
                                        'assets/images/funnels/pet_training/socialization.svg',
                                    heading: 'Socialization',
                                    detail:
                                        'Training increases your dog\'s confidence to explore the surroundings.'),
                              ),
                              SizedBox(
                                width: 13,
                              ),
                              Expanded(
                                child: WhyDogTrainingComponent(
                                    image:
                                        'assets/images/funnels/pet_training/mental_stimulation.svg',
                                    heading: 'Mental Stimulation',
                                    detail:
                                        'Engaging your dog\'s mind is as important as physical exercise.'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 17),
                      child: Column(
                        children: [
                          Text(
                            'Select Package',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                height: 1.5,
                                color: kTextColorBlue),
                          ),
                          Visibility(
                            visible: false,
                            child: BlocBuilder<PackageBloc, PackageState>(
                                builder: (blocContext, state) {
                              return Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(68)),
                                width: SizeConfig.blockSizeHorizontal * 70,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: PackageTypeSelector(
                                          boxDecoration: state.selectedPet ==
                                                  PetCategory.DOG
                                              ? kTabbedHeadingBlue
                                              : kTabbedHeadingWhite,
                                          onPressed: () => BlocProvider.of<
                                                  PackageBloc>(blocContext)
                                              .getDogGroomingPackagesForDetailPage(),
                                          title: 'Dogs',
                                          textStyle: state.selectedPet ==
                                                  PetCategory.DOG
                                              ? kActiveButtonTextStyle
                                              : kInactiveButtonTextStyle),
                                    ),
                                    Expanded(
                                      child: PackageTypeSelector(
                                          boxDecoration: state.selectedPet ==
                                                  PetCategory.CAT
                                              ? kTabbedHeadingBlue
                                              : kTabbedHeadingWhite,
                                          onPressed: () => BlocProvider.of<
                                                  PackageBloc>(blocContext)
                                              .getCatGroomingPackagesForDetailPage(),
                                          title: 'Cats',
                                          textStyle: state.selectedPet ==
                                                  PetCategory.CAT
                                              ? kActiveButtonTextStyle
                                              : kInactiveButtonTextStyle),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ),
                          SizedBox(
                            height: 18.5,
                          ),
                          BlocBuilder<PackageBloc, PackageState>(
                              builder: (blocContext, state) {
                            if (state.packages == null) {
                              BlocProvider.of<PackageBloc>(blocContext)
                                  .getDogTrainingPackagesForDetailPage();
                            }
                            if (state.loadingPackagesData) {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey[300] ?? Colors.grey,
                                highlightColor: Colors.white,
                                child: Container(
                                  width: 325.0,
                                  height: 169.0,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: Colors.grey),
                                ),
                              );
                            } else {
                              return state.packages!.data!.length == 0
                                  ? Center(
                                      child: NoDataAvailableComponent(
                                      mainText: 'No package available',
                                      subText: '',
                                    ))
                                  : SingleChildScrollView(
                                      child: Container(
                                        alignment: Alignment.topCenter,
                                        constraints: BoxConstraints(
                                          maxHeight: 480,
                                        ),
                                        child: ListView.builder(
                                            shrinkWrap: false,
                                            itemCount:
                                                state.packages!.data!.length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) =>
                                                TextButton(
                                                  style: TextButton.styleFrom(
                                                      padding:
                                                          EdgeInsets.all(0),
                                                      alignment:
                                                          Alignment.topCenter),
                                                  onPressed: () =>
                                                      Navigator.pushNamed(
                                                          context,
                                                          kNavigationPetTrainingFunnel),
                                                  child: CardPackageInfo(
                                                    currentFunnel:
                                                        FunnelType.PET_GROOMING,
                                                    name: state.packages!
                                                        .data![index].name!,
                                                    details: state.packages!
                                                        .data![index].detail!,
                                                    price: state.packages!
                                                        .data![index].price!,
                                                    selected: state
                                                            .selectedPackageIndex ==
                                                        index,
                                                    expand: true,
                                                  ),
                                                )),
                                      ),
                                    );
                            }
                          }),
                        ],
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
                      onPressed: () =>
                          Navigator.pushNamed(context, kNavigationReferAndEarn),
                      child: Container(
                          margin: EdgeInsets.only(top: 12),
                          padding: EdgeInsets.symmetric(
                              horizontal: 18, vertical: 15),
                          color: Colors.white,
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/home/refer_n_earn.svg',
                                height: 36,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Refer and Earn',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        height: 1.5,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    'Guaranteed reward for every referral',
                                    style: TextStyle(
                                        fontSize: 12,
                                        height: 1.5,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFFB6B7B9)),
                                  )
                                ],
                              )
                            ],
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 12),
                      color: kAppBackgroundColor,
                      child: Column(children: [
                        Text(
                          'Meet Our Pet Hero',
                          style: TextStyle(
                              color: kTextColorBlue,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              height: 1.5),
                        ),
                        BlocBuilder<HomeBloc, HomeState>(
                            builder: (blocContext, state) {
                          return Container(
                            margin: EdgeInsets.only(left: 18, top: 21),
                            height: 180,
                            child: state.homeData == null
                                ? CircularProgressIndicator()
                                : ListView.builder(
                                    itemCount: state.homeData!.partners!.length,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return PetHeroForDetailPage(
                                        name: state.homeData!.partners![index]
                                            .fullName!,
                                        ratings: state.homeData!
                                                    .partners![index].rating ==
                                                null
                                            ? "0"
                                            : state.homeData!.partners![index]
                                                .rating!
                                                .toString(),
                                        jobsDone: state.homeData!
                                            .partners![index].jobsCount!
                                            .toString(),
                                      );
                                    }),
                          );
                        }),
                      ]),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [kContainerBoxShadow]),
                      margin: EdgeInsets.only(top: 13),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 20, bottom: 18),
                            child: Row(children: [
                              Container(
                                height: 30,
                                width: 30,
                                margin: EdgeInsets.only(right: 5),
                                child: SvgPicture.asset(
                                    'assets/images/home/pet_service_heading.svg'),
                              ),
                              Text(
                                'Pet Services at Home with Safety',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              )
                            ]),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: PetServicesListDisplay(
                                  text: 'Sanitized Kits and Tools',
                                  image: 'assets/images/home/sanatise_icon.svg',
                                ),
                              ),
                              Expanded(
                                child: PetServicesListDisplay(
                                  text: 'Temperature Record',
                                  image: 'assets/images/home/temp_icon.svg',
                                ),
                              ),
                              Expanded(
                                child: PetServicesListDisplay(
                                  text: 'Updated Status on Arogya Setu App',
                                  image:
                                      'assets/images/home/arogya_setu_icon.svg',
                                ),
                              ),
                              Expanded(
                                child: PetServicesListDisplay(
                                  text: 'One Time Usable Products',
                                  image:
                                      'assets/images/home/one_time_product_icon.svg',
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 13, left: 20),
                            child: Text(
                              'What our customer says',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 16),
                            ),
                          ),
                          BlocBuilder<HomeBloc, HomeState>(
                              builder: (blocBuilder, state) {
                            return state.loading
                                ? CircularProgressIndicator()
                                : Container(
                                    margin: EdgeInsets.only(left: 20, top: 13),
                                    height: 175,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          state.homeData!.reviews!.length,
                                      itemBuilder: (context, index) {
                                        return PetParentReviewCard(
                                          name: state.homeData!.reviews![index]
                                              .user!.firstName!,
                                          date: state.homeData!.reviews![index]
                                              .reviewedAt!,
                                          rating: state.homeData!
                                              .reviews![index].rating!,
                                          userImage:
                                              "", //todo: images removed from design
                                          review: state.homeData!
                                              .reviews![index].feedback!,
                                        );
                                      },
                                    ),
                                  );
                          }),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.75),
                      child: SvgPicture.asset(
                          'assets/images/funnels/pet_training/city_list.svg'),
                    ),
                    SizedBox(
                      height: 100,
                    )
                  ],
                ),
              ),
              Positioned(
                child: Container(
                  width: SizeConfig.screenWidth,
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.23, vertical: 10.5),
                  color: Colors.white,
                  child: TextButton(
                    onPressed: () => Navigator.pushNamed(
                        context, kNavigationPetTrainingFunnel),
                    child: Container(
                        decoration: kActiveButtonContainerStyle,
                        padding: EdgeInsets.all(8),
                        child: Center(
                          child: Text(
                            'Book a Demo Session',
                            style: kActiveButtonTextStyle,
                          ),
                        )),
                  ),
                ),
                bottom: 0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
