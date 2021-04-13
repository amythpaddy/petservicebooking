import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_pet_nest/home/component/petHeroesCard.dart';
import 'package:the_pet_nest/home/component/petParentReviewCard.dart';
import 'package:the_pet_nest/home/component/petServicesDisplay.dart';
import 'package:the_pet_nest/home/component/servicesCard.dart';
import 'package:the_pet_nest/home/model/petHeroesModel.dart';
import 'package:the_pet_nest/home/model/petParentsReview.dart';
import 'package:the_pet_nest/home/model/services_model.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

enum BottomNavigationOptions { HOME, BOOKING, INVITE, ME }

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(22)),
                          color: Colors.transparent,
                        ),
                        margin: EdgeInsets.only(right: 20),
                        height: 162,
                        child: Stack(
                          children: [
                            Positioned(
                                child:
                                    Image.asset('assets/petgroomingimage.png')),
                            Positioned(
                                child: CustomPaint(
                              size: Size(232, 162),
                              painter: ServiceCardOrangePainter(),
                            )),
                            Positioned(
                                top: 28,
                                left: 18,
                                child: Container(
                                  width: 163,
                                  child: Text(
                                    'Pet grooming service at Home',
                                    style: TextStyle(
                                        color: Color(0xFF232C63),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15),
                                  ),
                                )),
                            Positioned(
                                top: 92,
                                left: 18,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      color: Colors.white),
                                  child: FlatButton(
                                    textColor: Color(0xFF232C63),
                                    child: Text(
                                      'Book Now',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14),
                                    ),
                                    onPressed: () {},
                                  ),
                                ))
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(22)),
                          color: Colors.transparent,
                        ),
                        margin: EdgeInsets.only(right: 20),
                        height: 162,
                        width: 365,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Image.asset('assets/vetimage.png'),
                            ),
                            Positioned(
                                child: CustomPaint(
                              size: Size(232, 162),
                              painter: ServiceCardOrangePainter(),
                            )),
                            Positioned(
                                top: 28,
                                left: 18,
                                child: Container(
                                  width: 231.63,
                                  child: Text(
                                    'Vet on call start from',
                                    style: TextStyle(
                                        color: Color(0xFF232C63),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15),
                                  ),
                                )),
                            Positioned(
                              left: 0,
                              top: 57.26,
                              child: CustomPaint(
                                painter: PricePainter(),
                                child: Container(
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  height: 24.74,
                                  child: Text.rich(TextSpan(children: [
                                    new TextSpan(
                                      text: '499',
                                      style: TextStyle(
                                        color: Color(0xFF232C63),
                                        fontSize: 15,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                    new TextSpan(
                                        text: ' /199',
                                        style: TextStyle(
                                          color: Color(0xFF232C63),
                                          fontSize: 15,
                                        )),
                                  ])),
                                ),
                              ),
                            ),
                            Positioned(
                                top: 92,
                                left: 18,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      color: Colors.white),
                                  child: FlatButton(
                                    textColor: Color(0xFF232C63),
                                    child: Text(
                                      'Talk to Vet',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14),
                                    ),
                                    onPressed: () {},
                                  ),
                                ))
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 20),
                        height: 162,
                        width: 335,
                        color: Colors.transparent,
                        child: Stack(
                          children: [
                            Positioned(
                                child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(1)),
                                    child: Image.asset(
                                      'assets/pettrainingimage.png',
                                      fit: BoxFit.fill,
                                    ))),
                            Positioned(
                                right: 0,
                                child: CustomPaint(
                                  size: Size(232, 162),
                                  painter: ServiceCardBluePainter(),
                                )),
                            Positioned(
                                top: 28,
                                left: 165,
                                child: Container(
                                  width: 154,
                                  child: Text(
                                    'Dog training service at Home',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                )),
                            Positioned(
                                top: 92,
                                right: 18,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      color: Colors.white),
                                  child: FlatButton(
                                    textColor: Color(0xFFFF7717),
                                    child: Text(
                                      'Schedule a Demo',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14),
                                    ),
                                    onPressed: () {},
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Services',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                ),
                Container(
                  height: 160,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: ServiceList.length,
                    itemBuilder: (context, index) {
                      print(ServiceList[index]['image']);
                      return ServicesCard(
                          text: ServiceList[index]['name'],
                          svgPath: ServiceList[index]['image']);
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
                        'How it works?',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Color(0xFF232C63)),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      SvgPicture.asset('assets/icons/home/how_it_work.svg'),
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
                                height: 1,
                                fontWeight: FontWeight.w400),
                          ),
                          Text('Schedule your\nappointment at\nhome',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10,
                                  height: 1,
                                  fontWeight: FontWeight.w400)),
                          Text(
                              'Sit back and relax!\nYour pet hero is on\nhis way',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10,
                                  height: 1,
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
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return PetHeroesCard(
                        name: PetHeroes[index]['name'],
                        service: PetHeroes[index]['job'],
                        appointmentCompleted: PetHeroes[index]
                            ['completed_appointments'],
                        rating: double.parse(
                            PetHeroes[index]['rating'].toString()));
                  },
                ),
                if (PetHeroes.length > 3) Center(child: Text('View More')),
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
            children: [
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SvgPicture.asset('assets/icons/home/refer_n_earn.svg'),
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
                margin: EdgeInsets.only(top: 13),
                padding: EdgeInsets.symmetric(vertical: 16),
                color: Colors.white,
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
                              'assets/icons/home/pet_service_heading.svg'),
                        ),
                        Text(
                          'Pet Services at Home with Safety',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 16),
                        )
                      ]),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PetServicesListDisplay(
                          text: 'Sanitized Kits and Tools',
                          image: 'assets/icons/home/sanatise_icon.svg',
                        ),
                        PetServicesListDisplay(
                          text: 'Temperature Record',
                          image: 'assets/icons/home/temp_icon.svg',
                        ),
                        PetServicesListDisplay(
                          text: 'Updated Status on Arogya Setu App',
                          image: 'assets/icons/home/arogya_setu_icon.svg',
                        ),
                        PetServicesListDisplay(
                          text: 'One Time Usable Products',
                          image: 'assets/icons/home/one_time_product_icon.svg',
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 13),
                child: Text(
                  'Reiews from Our Happy Pet Parrents',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, top: 13),
                height: 300,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: petParentReviews.length,
                  itemBuilder: (context, index) {
                    return PetParentReviewCard(
                      name: petParentReviews[index]['name'],
                      date: petParentReviews[index]['date'],
                      rating: double.parse(
                          petParentReviews[index]['rating'].toString()),
                      userImage: petParentReviews[index]['userImage'],
                      petImage: petParentReviews[index]['petImage'],
                      review: petParentReviews[index]['review'],
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 12),
                padding: EdgeInsets.symmetric(vertical: 12),
                color: Colors.white,
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

class ServiceCardOrangePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();

    paint.color = Color(0xffFF7717);
    path = Path();
    path.lineTo(0, size.height * 0.14);
    path.cubicTo(
        0, size.height * 0.06, size.width * 0.04, 0, size.width * 0.1, 0);
    path.cubicTo(size.width * 0.1, 0, size.width * 0.9, 0, size.width * 0.9, 0);
    path.cubicTo(size.width * 0.97, 0, size.width, size.height * 0.08,
        size.width, size.height * 0.17);
    path.cubicTo(size.width, size.height * 0.17, size.width * 0.87,
        size.height * 0.9, size.width * 0.87, size.height * 0.9);
    path.cubicTo(size.width * 0.86, size.height * 0.96, size.width * 0.82,
        size.height, size.width * 0.78, size.height);
    path.cubicTo(size.width * 0.78, size.height, size.width * 0.1, size.height,
        size.width * 0.1, size.height);
    path.cubicTo(size.width * 0.04, size.height, 0, size.height * 0.94, 0,
        size.height * 0.87);
    path.cubicTo(
        0, size.height * 0.87, 0, size.height * 0.14, 0, size.height * 0.14);
    path.cubicTo(
        0, size.height * 0.14, 0, size.height * 0.14, 0, size.height * 0.14);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class ServiceCardBluePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();

    // Path number 1

    paint.color = Color(0xff232C63);
    path = Path();
    path.lineTo(size.width, size.height * 0.87);
    path.cubicTo(size.width, size.height * 0.94, size.width * 0.96, size.height,
        size.width * 0.9, size.height);
    path.cubicTo(size.width * 0.9, size.height, size.width * 0.1, size.height,
        size.width * 0.1, size.height);
    path.cubicTo(size.width * 0.03, size.height, -0.01, size.height * 0.92, 0,
        size.height * 0.84);
    path.cubicTo(0, size.height * 0.84, size.width * 0.13, size.height * 0.11,
        size.width * 0.13, size.height * 0.11);
    path.cubicTo(size.width * 0.14, size.height * 0.05, size.width * 0.18, 0,
        size.width * 0.22, 0);
    path.cubicTo(
        size.width * 0.22, 0, size.width * 0.9, 0, size.width * 0.9, 0);
    path.cubicTo(size.width * 0.96, 0, size.width, size.height * 0.06,
        size.width, size.height * 0.14);
    path.cubicTo(size.width, size.height * 0.14, size.width, size.height * 0.87,
        size.width, size.height * 0.87);
    path.cubicTo(size.width, size.height * 0.87, size.width, size.height * 0.87,
        size.width, size.height * 0.87);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class PricePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();

    paint.color = Colors.white;
    path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width - 10, size.height / 2)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
