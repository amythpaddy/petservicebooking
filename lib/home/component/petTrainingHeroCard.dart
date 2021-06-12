import 'package:flutter/material.dart';
import 'package:the_pet_nest/home/component/coloredCardPainter.dart';
import 'package:the_pet_nest/konstants/paths.dart';

class PetTrainingHeroCard extends StatelessWidget {
  const PetTrainingHeroCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      height: 162,
      width: 335,
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned(
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(1)),
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
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              )),
          Positioned(
              top: 92,
              right: 18,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Colors.white),
                child: FlatButton(
                  textColor: Color(0xFFFF7717),
                  child: Text(
                    'Schedule a Demo',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, kNavigationPetTrainingFunnel);
                  },
                ),
              ))
        ],
      ),
    );
  }
}
