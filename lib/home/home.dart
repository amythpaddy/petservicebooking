import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_pet_nest/config/sizeConfig.dart';
import 'package:the_pet_nest/home/component/petGroomingHeroCard.dart';
import 'package:the_pet_nest/home/component/petHeroesCard.dart';
import 'package:the_pet_nest/home/component/petParentReviewCard.dart';
import 'package:the_pet_nest/home/component/petServicesDisplay.dart';
import 'package:the_pet_nest/home/component/petTrainingHeroCard.dart';
import 'package:the_pet_nest/home/component/petVetHeroCard.dart';
import 'package:the_pet_nest/home/component/servicesCard.dart';
import 'package:the_pet_nest/home/model/petHeroesModel.dart';
import 'package:the_pet_nest/home/model/petParentsReview.dart';
import 'package:the_pet_nest/home/model/services_model.dart';
import 'package:the_pet_nest/konstants/colors.dart';
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
                ),
                Container(
                  height: 160,
                  color: kAppBackgroundColor,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: ServiceList.length,
                    itemBuilder: (context, index) {
                      print(ServiceList[index]['image']);
                      return ServicesCard(
                          text: ServiceList[index]['name']!,
                          svgPath: ServiceList[index]['image']!);
                    },
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
                          Text(
                              'Sit back and relax!\nYour pet hero is on\nhis way',
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
                Container(
                  margin: EdgeInsets.only(top: 13, bottom: 10),
                  child: Text(
                    'Pet Heroes of the month',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 17, height: 1.5),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return PetHeroesCard(
                        name: PetHeroes[index]['name'].toString(),
                        service: PetHeroes[index]['job'].toString(),
                        appointmentCompleted: int.parse(PetHeroes[index]
                                ['completed_appointments']
                            .toString()),
                        rating: double.parse(
                            PetHeroes[index]['rating'].toString()));
                  },
                ),
                if (PetHeroes.length > 3)
                  Center(
                      child: Text(
                    'View More',
                    style: TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 10, height: 1.5),
                  )),
                if (PetHeroes.length > 3)
                  Center(
                      child: Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                              color: Colors.white),
                          child: Icon(Icons.keyboard_arrow_down)))
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white, boxShadow: [kContainerBoxShadow]),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SvgPicture.asset('assets/images/home/refer_n_earn.svg'),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Refer and Earn',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 15),
                          ),
                          Text(
                            'Guaranteed reward for every referral',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 12),
                          )
                        ],
                      )
                    ],
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
                        PetServicesListDisplay(
                          text: 'Sanitized Kits and Tools',
                          image: 'assets/images/home/sanatise_icon.svg',
                        ),
                        PetServicesListDisplay(
                          text: 'Temperature Record',
                          image: 'assets/images/home/temp_icon.svg',
                        ),
                        PetServicesListDisplay(
                          text: 'Updated Status on Arogya Setu App',
                          image: 'assets/images/home/arogya_setu_icon.svg',
                        ),
                        PetServicesListDisplay(
                          text: 'One Time Usable Products',
                          image: 'assets/images/home/one_time_product_icon.svg',
                        )
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
              Container(
                margin: EdgeInsets.only(left: 20, top: 13),
                height: 175,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: petParentReviews.length,
                  itemBuilder: (context, index) {
                    return PetParentReviewCard(
                      name: petParentReviews[index]['name'].toString(),
                      date: petParentReviews[index]['date'].toString(),
                      rating: double.parse(
                          petParentReviews[index]['rating'].toString()),
                      userImage:
                          petParentReviews[index]['userImage'].toString(),
                      review: petParentReviews[index]['review'].toString(),
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 12),
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                    color: Colors.white, boxShadow: [kContainerBoxShadow]),
                child: Center(child: Image.asset('assets/skillindia.png')),
              )
            ],
          ),
          SizedBox(
            height: 150,
          )
        ],
      ),
    );
  }
}
