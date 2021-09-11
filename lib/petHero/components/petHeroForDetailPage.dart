import 'package:flutter/material.dart';

class PetHeroForDetailPage extends StatelessWidget {
  const PetHeroForDetailPage(
      {Key? key,
      required this.name,
      required this.jobsDone,
      required this.ratings})
      : super(key: key);
  final String name;
  final String jobsDone;
  final String ratings;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 15),
      child: Column(
        children: [
          CircleAvatar(
            maxRadius: 46,
            child: Text(name.substring(0, 1)),
          ),
          Text(
            name,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                height: 1.5,
                color: Colors.black),
          ),
          Text(
            '$ratings Star Rating \n $jobsDone Grooming Done',
            style: TextStyle(
                color: Color(0xFF767982),
                fontSize: 10,
                height: 1.5,
                fontWeight: FontWeight.w300),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
