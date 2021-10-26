import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_pet_nest/config/sizeConfig.dart';
import 'package:the_pet_nest/home/bloc/homeBloc.dart';
import 'package:the_pet_nest/home/bloc/homeState.dart';
import 'package:the_pet_nest/home/component/petGroomingHeroCard.dart';
import 'package:the_pet_nest/home/component/petHeroesCard.dart';
import 'package:the_pet_nest/home/component/petParentReviewCard.dart';
import 'package:the_pet_nest/home/component/petServicesDisplay.dart';
import 'package:the_pet_nest/home/component/petTrainingHeroCard.dart';
import 'package:the_pet_nest/home/component/petVetHeroCard.dart';
import 'package:the_pet_nest/home/component/servicesCard.dart';
import 'package:the_pet_nest/home/model/services_model.dart';
import 'package:the_pet_nest/konstants/paths.dart';
import 'package:the_pet_nest/konstants/styles.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

enum BottomNavigationOptions { HOME, BOOKING, INVITE, ME }

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SingleChildScrollView(
      child: BlocProvider(
        create: (_) => HomeBloc(HomeState()),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 20.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    PetGroomingHeroCard(),
                    PetVetHeroCard(),
                    PetTrainingHeroCard(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Services',
                    style: TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 17, height: 1.5),
                  ),SizedBox(height:9.57),
                  Row(
                    children: [
                      Expanded(
                        child: ServicesCard(
                          text: ServiceList[0]['name']!,
                          svgPath: ServiceList[0]['image']!,
                          onClick: () => Navigator.pushNamed(
                              context, kNavigationPetGroomingDetail),
                        ),
                      ),
                      Expanded(
                        child: ServicesCard(
                          text: ServiceList[1]['name']!,
                          svgPath: ServiceList[1]['image']!,
                          onClick: () => Navigator.pushNamed(
                              context, kNavigationPetTrainingDetail),
                        ),
                      ),
                      Expanded(
                        child: ServicesCard(
                          text: ServiceList[2]['name']!,
                          svgPath: ServiceList[2]['image']!,
                          onClick: () => Navigator.pushNamed(
                              context, kNavigationVetDetail),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 13, bottom: 10),
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'How it work?',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Color(0xFF232C63)),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  SvgPicture.asset('assets/images/home/how_it_work.svg'),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Search pet cares\nheroes by location\nand service',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10,
                            height: 1.5,
                            fontWeight: FontWeight.w400),
                      ),
                      Text('Schedule your\nappointment at\nhome',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10,
                              height: 1.5,
                              fontWeight: FontWeight.w400)),
                      Text('Sit back and relax!\nYour pet hero is on\nhis way',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10,
                              height: 1.5,
                              fontWeight: FontWeight.w400))
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 13, bottom: 10),
                    child: Text(
                      'Pet Heroes of the month',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          height: 1.5),
                    ),
                  ),
                  BlocBuilder<HomeBloc, HomeState>(
                      builder: (blocContext, state) {
                    return state.loading
                        ? Center(
                            child: Container(
                                width: 40, child: CircularProgressIndicator()))
                        : Column(
                            children: [
                              ListView.builder(
                                padding: EdgeInsets.all(0),
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: state.showAllPetHeroes
                                    ? state.homeData!.partners!.length
                                    : 3,
                                itemBuilder: (context, index) {
                                  return PetHeroesCard(
                                      name: state
                                          .homeData!.partners![index].fullName!,
                                      service: state.homeData!.partners![index]
                                          .partnerType!,
                                      appointmentCompleted: state.homeData!
                                              .partners![index].jobsCount ??
                                          0,
                                      rating: state.homeData!.partners![index]
                                              .rating ??
                                          0);
                                },
                              ),
                              Visibility(
                                visible: state.homeData!.partners!.length > 3 &&
                                    !state.showAllPetHeroes,
                                child: Center(
                                    child: Text(
                                  'View More',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10,
                                      height: 1.5),
                                )),
                              ),
                              Visibility(
                                  visible:
                                      state.homeData!.partners!.length > 3 &&
                                          !state.showAllPetHeroes,
                                  child: Center(
                                      child: TextButton(
                                    style: TextButton.styleFrom(
                                        padding: EdgeInsets.all(0)),
                                    onPressed:
                                        BlocProvider.of<HomeBloc>(blocContext)
                                            .showMorePetHeroes,
                                    child: Container(
                                        width: 25,
                                        height: 25,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(25)),
                                            color: Colors.white),
                                        child: Icon(Icons.keyboard_arrow_down)),
                                  )))
                            ],
                          );
                  }),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, kNavigationReferAndEarn),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white, boxShadow: [kContainerBoxShadow]),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SvgPicture.asset(
                              'assets/images/home/refer_n_earn.svg'),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Refer and Earn',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                    color: Colors.black),
                              ),
                              Text(
                                'Guaranteed reward for every referral',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: Colors.black),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white, boxShadow: [kContainerBoxShadow]),
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
                              image: 'assets/images/home/arogya_setu_icon.svg',
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
                  margin: EdgeInsets.only(top: 13, left: 20),
                  child: Text(
                    'What our customer says',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                ),
                BlocBuilder<HomeBloc, HomeState>(builder: (blocBuilder, state) {
                  return state.loading
                      ? Center(child: CircularProgressIndicator())
                      : Container(
                          margin: EdgeInsets.only(left: 20, top: 13),
                          height: 175,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: state.homeData!.reviews!.length,
                            itemBuilder: (context, index) {
                              return PetParentReviewCard(
                                name: state
                                    .homeData!.reviews![index].user!.firstName!,
                                date:
                                    state.homeData!.reviews![index].reviewedAt!,
                                rating: state.homeData!.reviews![index].rating!,
                                userImage:
                                    "", //todo: images removed from design
                                review:
                                    state.homeData!.reviews![index].feedback!,
                              );
                            },
                          ),
                        );
                }),
                Container(
                  margin: EdgeInsets.only(top: 12),
                  padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                      color: Colors.white, boxShadow: [kContainerBoxShadow]),
                  child: Center(
                      child: Image.asset(
                    'assets/skillindia.png',
                    width: 128.85,
                    height: 91.04,
                  )),
                )
              ],
            ),
            SizedBox(
              height: 150,
            )
          ],
        ),
      ),
    );
  }
}
