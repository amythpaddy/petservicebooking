import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:the_pet_nest/addressBook/bloc/addressBookBloc.dart';
import 'package:the_pet_nest/addressBook/bloc/addressBookState.dart';
import 'package:the_pet_nest/config/sizeConfig.dart';
import 'package:the_pet_nest/funnels/bloc/packageBloc/packageBloc.dart';
import 'package:the_pet_nest/funnels/bloc/packageBloc/packageState.dart';
import 'package:the_pet_nest/funnels/bloc/serviceDetailBloc/serviceDetailBloc.dart';
import 'package:the_pet_nest/funnels/bloc/serviceDetailBloc/serviceDetailState.dart';
import 'package:the_pet_nest/funnels/petGrooming/component/howItWorksCard.dart';
import 'package:the_pet_nest/funnels/vetFunnel/components/VetConsultationDetailComponent.dart';
import 'package:the_pet_nest/funnels/vetFunnel/components/nutritionistConsultationDetailComponent.dart';
import 'package:the_pet_nest/home/bloc/homeBloc.dart';
import 'package:the_pet_nest/home/bloc/homeState.dart';
import 'package:the_pet_nest/home/component/petParentReviewCard.dart';
import 'package:the_pet_nest/home/component/petServicesDisplay.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/paths.dart';
import 'package:the_pet_nest/konstants/styles.dart';
import 'package:the_pet_nest/konstants/values.dart';
import 'package:the_pet_nest/petHero/components/petHeroForDetailPage.dart';

class VetDetail extends StatelessWidget {
  VetDetail({Key? key}) : super(key: key);
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
        BlocProvider(
            create: (_) => AddressBookBloc(initialState: AddressBookState())),
        BlocProvider(create: (_) => HomeBloc(HomeState())),
        BlocProvider(
            create: (_) =>
                ServiceDetailBloc(ServiceDetailState(), leadType: kLeadTypeVet))
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AddressBookBloc, AddressBookState>(
              listener: (blocContext, state) {
            if (state.cityList != null) {
              state.cityList!.cityList.forEach((element) {
                if (element.cityName == 'Delhi') {
                  BlocProvider.of<PackageBloc>(blocContext)
                      .getVetScreedDetailPackages(element.cityId);
                }
              });
            }
          })
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
                                'assets/images/funnels/vet_service/vet_service_hero.png'),
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
                                          context, kNavigationVetFunnel),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 36.5),
                                        decoration: kActiveButtonContainerStyle,
                                        child: Text(
                                          'Talk to a Vet',
                                          style: kActiveButtonTextStyle,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 14.55,
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Text(
                                        'Connect With a Vet Expert Online in Under 1 Minute',
                                        style:
                                            TextStyle(color: Color(0xFFE5E5E5)),
                                        textAlign: TextAlign.center,
                                      ),
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
                                    color: Colors.black45,
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
                          children: [
                            Text(
                              'How it works?',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                  height: 1.5,
                                  color: kTextColorBlue),
                            ),
                            HowItWorksComponent(
                                icon:
                                    'assets/images/funnels/vet_service/icon_question.svg',
                                heading: 'Ask a question',
                                detail:
                                    'Ask anything related to health, nutrition, behavior of your Pet'),
                            HowItWorksComponent(
                                icon:
                                    'assets/images/funnels/vet_service/icon_tell_more.svg',
                                heading: 'Tell us more ',
                                detail:
                                    'You can even upload photos and medical documents if you desire'),
                            HowItWorksComponent(
                                icon:
                                    'assets/images/funnels/vet_service/icon_vet_expert.svg',
                                heading: 'Connect with Vet Expert',
                                detail:
                                    'A real Veterinarian answers your questions and/or begins LIVE chat with you'),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 12.5),
                        child: BlocBuilder<PackageBloc, PackageState>(
                          builder: (blocContext, state) {
                            return Column(
                              children: [
                                TextButton(
                                  onPressed: () => Navigator.pushNamed(
                                      context, kNavigationVetFunnel),
                                  style: TextButton.styleFrom(
                                      padding: EdgeInsets.all(0)),
                                  child: VetConsultationComponent(
                                      heading: 'Talk to a Vet now',
                                      subText:
                                          'Connect with our network of licensed veterinarians ASAP, 24/7',
                                      price: state.prices == null
                                          ? '199'
                                          : state.prices![0] ?? '199'),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pushNamed(
                                      context, kNavigationVetFunnel),
                                  style: TextButton.styleFrom(
                                      padding: EdgeInsets.all(0)),
                                  child: VetConsultationComponent(
                                      heading: 'Book In-Home Vet visit.',
                                      subText:
                                          'Let our Vet Expert treat your pet at Home.',
                                      price: state.prices == null
                                          ? '199'
                                          : state.prices![1] ?? '199'),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10.5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Consult a specialist',
                                        style: TextStyle(
                                            fontSize: 18,
                                            height: 1.5,
                                            fontWeight: FontWeight.w600,
                                            color: kTextColorBlue),
                                      ),
                                      Text(
                                        'Request an appointment with an expert',
                                        style: TextStyle(
                                            color: Color(0xFF8C8F96),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            height: 1.5),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.pushNamed(
                                            context, kNavigationVetFunnel),
                                        style: TextButton.styleFrom(
                                            padding: EdgeInsets.all(0)),
                                        child: NutritionistConsultationDetailComponent(
                                            image:
                                                'assets/images/funnels/vet_service/icon_talk_to_behaviorist.svg',
                                            title: 'Talk to a behaviorist',
                                            price: state.prices == null
                                                ? '999'
                                                : state.prices![2] ?? '999'),
                                      ),
                                      Divider(),
                                      TextButton(
                                        onPressed: () => Navigator.pushNamed(
                                            context, kNavigationVetFunnel),
                                        style: TextButton.styleFrom(
                                            padding: EdgeInsets.all(0)),
                                        child: NutritionistConsultationDetailComponent(
                                            image:
                                                'assets/images/funnels/vet_service/talk_to_nutritionist.svg',
                                            title: 'Talk to a nutritionist',
                                            price: state.prices == null
                                                ? '999'
                                                : state.prices![3] ?? '999'),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                      Container(
                        width: SizeConfig.screenWidth,
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
                          BlocBuilder<ServiceDetailBloc, ServiceDetailState>(
                              builder: (blocContext, state) {
                            return Container(
                              margin: EdgeInsets.only(left: 18, top: 21),
                              height: 180,
                              child: state.fetchingData
                                  ? CircularProgressIndicator()
                                  : ListView.builder(
                                      itemCount: state.petHeroList!.data.length,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return PetHeroForDetailPage(
                                            name: state.petHeroList!.data[index]
                                                .fullName!,
                                            ratings: state.petHeroList!
                                                        .data[index].rating ==
                                                    null
                                                ? "0"
                                                : state.petHeroList!.data[index]
                                                    .rating!
                                                    .toString(),
                                            jobsDone: "");
                                      }),
                            );
                          })
                        ]),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
                        onPressed: () => Navigator.pushNamed(
                            context, kNavigationReferAndEarn),
                        child: Container(
                            margin: EdgeInsets.only(top: 12),
                            padding: EdgeInsets.symmetric(
                                horizontal: 18, vertical: 15),
                            color: Colors.white,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/images/home/refer_n_earn.svg',
                                  height: 56,
                                  width: 56,
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
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
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
                                    image:
                                        'assets/images/home/sanatise_icon.svg',
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
                                      margin:
                                          EdgeInsets.only(left: 20, top: 13),
                                      height: 150,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            state.homeData!.reviews!.length,
                                        itemBuilder: (context, index) {
                                          return PetParentReviewCard(
                                            name: state
                                                .homeData!
                                                .reviews![index]
                                                .user!
                                                .firstName!,
                                            date: state.homeData!
                                                .reviews![index].reviewedAt!,
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
                      SizedBox(
                        height: 100,
                      )
                    ],
                  ),
                ),
                Positioned(
                  child: Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.only(top: 10),
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.23, vertical: 10.5),
                    color: Colors.white,
                    child: TextButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, kNavigationVetFunnel),
                      child: Container(
                          decoration: kActiveButtonContainerStyle,
                          padding: EdgeInsets.all(8),
                          child: Center(
                            child: Text(
                              'Talk a Vet Expert',
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
      ),
    );
  }
}
