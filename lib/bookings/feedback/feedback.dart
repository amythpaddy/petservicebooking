import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_pet_nest/bookings/feedback/component/dotIndicator.dart';
import 'package:the_pet_nest/bookings/feedback/component/swipeQuestionCards.dart';
import 'package:the_pet_nest/bookings/feedback/model/feedbackQuestions.dart';
import 'package:the_pet_nest/bookings/model/feedbackDataHolder.dart';
import 'package:the_pet_nest/konstants/styles.dart';

class PetheroFeedback extends StatelessWidget {
  late FeedbackDataHolder args;
  PageController pageController = PageController(initialPage: 0);

//  PageView feedbackQuestionsPV = ;

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments as FeedbackDataHolder;
//    args = FeedbackDataHolder('Karan Johar', 'Delhi');
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          child: TextButton(
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          alignment: Alignment.topCenter,
          margin: EdgeInsets.only(top: 18),
        ),
        centerTitle: true,
        title: Container(
          margin: EdgeInsets.only(right: 50),
          child: Column(
            children: [
              SizedBox(
                height: 21,
              ),
              Image.asset('assets/images/feedback/placeholder.png'),
              SizedBox(height: 8.5),
              Text(
                args.petHero,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    height: 1.5,
                    fontWeight: FontWeight.w500),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/images/feedback/location.svg'),
                  Text(args.city,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          height: 1.5,
                          fontWeight: FontWeight.w400))
                ],
              )
            ],
          ),
        ),
        backgroundColor: Color(0xFF232C63),
        toolbarHeight: 200,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'How was your service?',
              style: TextStyle(
                  fontWeight: FontWeight.w500, fontSize: 20, height: 1.5),
            ),
            RatingBar(
              itemCount: 5,
              itemSize: 50,
              ratingWidget: RatingWidget(
                  full: Icon(
                    Icons.star_rounded,
                    color: Color(0xFFFFC107),
                    size: 36,
                  ),
                  half: Icon(
                    Icons.star_rounded,
                    color: Color(0xFFFFC107),
                    size: 36,
                  ),
                  empty: Icon(Icons.star_outline_rounded,
                      size: 36, color: Color(0xFFFFC107))),
              onRatingUpdate: (rating) {},
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              color: Colors.white,
              child: Stack(
                children: [
                  PageView.builder(
                    itemBuilder: (context, index) {
                      return SwipeQuestionCard(
                        question: feedbackQuestions[index]['question'],
                        option1: feedbackQuestions[index]['option1'],
                        option3: feedbackQuestions[index]['option3'],
                        option2: feedbackQuestions[index]['option2'],
                      );
                    },
                    itemCount: feedbackQuestions.length,
                    controller: pageController,
                  ),
                  Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: DotIndicator(
                        controller: pageController,
                        itemCount: feedbackQuestions.length,
                        onPageSelected: (page) {},
                      ))
                ],
              ),
              height: 300,
            ),
            TextField(
              autofocus: false,
              maxLines: 5,
              decoration: InputDecoration(
                  hintText: 'Tell us something',
                  hintStyle: TextStyle(color: Color(0x771A202E)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(12))),
            ),
            Row(
              children: [
                SvgPicture.asset('assets/images/feedback/message_icon.svg'),
                Flexible(
                    child: Text(
                  'Your feedback helps to make ThePetNest community better!',
                  textAlign: TextAlign.center,
                ))
              ],
            ),
            TextButton(
                onPressed: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  width: double.infinity,
                  decoration: kActiveButtonContainerStyle,
                  child: Text(
                    'Submit Feedback',
                    style: kActiveButtonTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
