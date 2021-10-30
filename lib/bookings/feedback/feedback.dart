import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_pet_nest/bookings/feedback/bloc/feedbackBloc.dart';
import 'package:the_pet_nest/bookings/feedback/bloc/feedbackState.dart';
import 'package:the_pet_nest/bookings/feedback/component/dotIndicator.dart';
import 'package:the_pet_nest/bookings/feedback/component/swipeQuestionCards.dart';
import 'package:the_pet_nest/bookings/model/feedbackDataHolder.dart';
import 'package:the_pet_nest/config/sizeConfig.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/styles.dart';

class PetHeroFeedback extends StatelessWidget {
//  PageView feedbackQuestionsPV = ;

  @override
  Widget build(BuildContext context) {
    FeedbackDataHolder args =
        ModalRoute.of(context)!.settings.arguments as FeedbackDataHolder;
    PageController pageController = PageController(initialPage: 0);

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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 21,
              ),
              SvgPicture.asset(
                'assets/images/feedback/placeholder.svg',
                height: 72,
                width: 72,
              ),
              SizedBox(height: 8.5),
              Center(
                child: Text(
                  args.petHero.isNotEmpty ? args.petHero : "Pet Hero",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      height: 1.5,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Visibility(
                visible: args.city.isNotEmpty,
                child: Row(
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
                ),
              )
            ],
          ),
        ),
        backgroundColor: Color(0xFF232C63),
        toolbarHeight: 200,
      ),
      body: BlocProvider(
        create: (_) =>
            FeedbackBloc(initialState: FeedbackState(), leadId: args.leadId),
        child: BlocListener<FeedbackBloc, FeedbackState>(
          listener: (blocContext, state) {
            if (state.feedbackUpdated) Navigator.pop(context);
          },
          child: BlocBuilder<FeedbackBloc, FeedbackState>(
            builder: (blocContext, state) {
              return state.loading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: kAppIconColor,
                      ),
                    )
                  : Stack(
                      children: [
                        SingleChildScrollView(
                            padding: EdgeInsets.all(25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'How was your service?',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      height: 1.5),
                                ),
                                RatingBar(
                                  itemCount: 5,
                                  itemSize: 50,
                                  initialRating: state.feedbackExists
                                      ? state.feedbackData!.rating
                                      : 0,
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
                                  onRatingUpdate: (rating) =>
                                      BlocProvider.of<FeedbackBloc>(blocContext)
                                          .updateRating(rating),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Visibility(
                                  visible: (state.feedbackExists &&
                                          state.feedbackData!.userFeedback
                                                  .length >
                                              0) ||
                                      (!state.feedbackExists &&
                                          state.feedbackData!.userQuestions
                                                  .length >
                                              0),
                                  child: Container(
                                    color: Colors.white,
                                    child: Stack(
                                      children: [
                                        PageView.builder(
                                          itemBuilder: (context, index) {
                                            return SwipeQuestionCard(
                                                question: state.feedbackExists
                                                    ? state
                                                        .feedbackData!
                                                        .userFeedback[index]
                                                        .question
                                                    : state
                                                        .feedbackData!
                                                        .userQuestions[index]
                                                        .question,
                                                options: state.feedbackExists
                                                    ? state
                                                        .feedbackData!
                                                        .userFeedback[index]
                                                        .answer
                                                    : state
                                                        .feedbackData!
                                                        .userQuestions[index]
                                                        .options,
                                                editable: !state.feedbackExists,
                                                optionSelected: state
                                                            .feedbackData!
                                                            .userFeedback
                                                            .length >=
                                                        index + 1
                                                    ? state
                                                        .feedbackData!
                                                        .userFeedback[index]
                                                        .answer
                                                    : "",
                                                onOptionSelected: (question,
                                                        answer) =>
                                                    BlocProvider.of<
                                                                FeedbackBloc>(
                                                            blocContext)
                                                        .updateFeedbackOptions(
                                                            question,
                                                            answer,
                                                            index));
                                          },
                                          itemCount: state.feedbackExists
                                              ? state.feedbackData!.userFeedback
                                                  .length
                                              : state.feedbackData!
                                                  .userQuestions.length,
                                          controller: pageController,
                                        ),
                                        Positioned(
                                            bottom: 0,
                                            left: 0,
                                            right: 0,
                                            child: DotIndicator(
                                              controller: pageController,
                                              itemCount: state.feedbackExists
                                                  ? state.feedbackData!
                                                      .userFeedback.length
                                                  : state.feedbackData!
                                                      .userQuestions.length,
                                              onPageSelected: (page) {},
                                            ))
                                      ],
                                    ),
                                    height: 300,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  autofocus: false,
                                  maxLines: 5,
                                  initialValue: state.feedbackData!.review,
                                  enabled: !state.feedbackExists,
                                  onChanged: (text) =>
                                      BlocProvider.of<FeedbackBloc>(blocContext)
                                          .updateReview(text),
                                  decoration: InputDecoration(
                                      hintText: 'Tell us something',
                                      hintStyle:
                                          TextStyle(color: Color(0x771A202E)),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(12))),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 2),
                                      child: SvgPicture.asset(
                                          'assets/images/feedback/message_icon.svg'),
                                    ),
                                    Flexible(
                                        child: Text(
                                      'Your feedback helps to make ThePetNest community better!',
                                      textAlign: TextAlign.center,
                                    )),
                                    SizedBox(
                                      width: 10,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 70,
                                ),
                              ],
                            )),
                        Positioned(
                            bottom: 0,
                            child: Visibility(
                              visible: !state.feedbackExists,
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                color: Colors.white,
                                child: TextButton(
                                    style: TextButton.styleFrom(
                                        padding: EdgeInsets.all(0)),
                                    onPressed: () {
                                      if (!state.updatingFeedback)
                                        BlocProvider.of<FeedbackBloc>(
                                                blocContext)
                                            .sendFeedback(args.leadId);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 20),
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(
                                          vertical:
                                              state.updatingFeedback ? 0 : 14),
                                      width:
                                          SizeConfig.blockSizeHorizontal * 95,
                                      height: 50,
                                      decoration: kActiveButtonContainerStyle,
                                      child: state.updatingFeedback
                                          ? Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 150, vertical: 5),
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                              ),
                                            )
                                          : Text(
                                              'Submit Feedback',
                                              style: kActiveButtonTextStyle,
                                              textAlign: TextAlign.center,
                                            ),
                                    )),
                              ),
                            ))
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}
