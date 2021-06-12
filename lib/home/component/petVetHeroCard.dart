import 'package:flutter/material.dart';
import 'package:the_pet_nest/home/component/coloredCardPainter.dart';

class PetVetHeroCard extends StatelessWidget {
  const PetVetHeroCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      text: ' /\u{20B9}199',
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
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Colors.white),
                child: FlatButton(
                  textColor: Color(0xFF232C63),
                  child: Text(
                    'Talk to Vet',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                  ),
                  onPressed: () {},
                ),
              ))
        ],
      ),
    );
  }
}
