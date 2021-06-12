import 'package:flutter/material.dart';
import 'package:the_pet_nest/home/component/coloredCardPainter.dart';

class PetGroomingHeroCard extends StatelessWidget {
  const PetGroomingHeroCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(22)),
        color: Colors.transparent,
      ),
      margin: EdgeInsets.only(right: 20),
      child: Stack(
        children: [
          Positioned(
            child: Image.asset(
              'assets/petgroomingimage.png',
              fit: BoxFit.fill,
              height: 162,
              width: 335,
            ),
          ),
          Positioned(
              child: CustomPaint(
            size: Size(231.63, 162),
            painter: ServiceCardOrangePainter(),
          )),
          Positioned(
              child: Container(
            margin: EdgeInsets.only(top: 27.9, left: 17.64),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pet grooming service \nat Home',
                  style: TextStyle(
                      color: Color(0xFF232C63),
                      fontWeight: FontWeight.w400,
                      fontSize: 15),
                ),
                SizedBox(
                  height: 17.84,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: Colors.white),
                  child: FlatButton(
                    textColor: Color(0xFF232C63),
                    child: Text(
                      'Book Now',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
