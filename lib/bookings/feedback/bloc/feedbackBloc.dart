import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_pet_nest/bookings/feedback/bloc/feedbackEvent.dart';
import 'package:the_pet_nest/bookings/feedback/bloc/feedbackState.dart';
import 'package:the_pet_nest/bookings/feedback/model/feedbackInternalModel.dart';
import 'package:the_pet_nest/konstants/endpoints.dart';
import 'package:the_pet_nest/utils/ApiCaller.dart';

class FeedbackBloc extends Bloc<FeedbackEvents, FeedbackState> {
  FeedbackBloc({required FeedbackState initialState, required this.leadId})
      : super(initialState) {
    getSavedFeedback(this.leadId);
  }
  final String leadId;
  FeedbackInternalModel _feedbackData = FeedbackInternalModel();

  @override
  Stream<FeedbackState> mapEventToState(FeedbackEvents event) async* {
    if (event == FeedbackEvents.FEEDBACK_FETCHED) {
      yield state.copyWith(
          loading: false, feedbackData: _feedbackData, feedbackExists: true);
    } else if (event == FeedbackEvents.FEEDBACK_UPLOADED) {
      yield state.copyWith(
          loading: false, feedbackData: _feedbackData, feedbackExists: false);
    } else if (event == FeedbackEvents.FEEDBACK_QUESTIONS_FETCHED) {
      yield state.copyWith(loading: false, feedbackData: _feedbackData);
    } else if (event == FeedbackEvents.LOADING) {
      yield state.copyWith(loading: true);
    } else if (event == FeedbackEvents.UPDATE_FEEDBACK_OPTIONS) {
      yield state.copyWith(feedbackData: _feedbackData);
    } else if (event == FeedbackEvents.UPDATING_FEEDBACK) {
      yield state.copyWith(updatingFeedback: true);
    } else if (event == FeedbackEvents.FEEDBACK_UPLOADED) {
      yield state.copyWith(feedbackUpdated: true);
    }
  }

  void getSavedFeedback(String leadId) async {
    var response =
        await ApiCaller.get(kUrlGetFeedbackContent(leadId), withToken: true);
    _feedbackData = FeedbackInternalModel.fromSavedFeedback(response);
    if (_feedbackData.userFeedback.isEmpty && _feedbackData.rating == 0) {
      getFeedbackQuestions(leadId);
    } else {
      add(FeedbackEvents.FEEDBACK_FETCHED);
    }
  }

  void getFeedbackQuestions(String leadId) async {
    var response =
        await ApiCaller.get(kUrlGetFeedbackQuestions(leadId), withToken: true);
    _feedbackData = FeedbackInternalModel.fromQuestionsList(response);
    add(FeedbackEvents.FEEDBACK_QUESTIONS_FETCHED);
  }

  void sendFeedback(String leadId) async {
    add(FeedbackEvents.UPDATING_FEEDBACK);
    await ApiCaller.post(
        kUrlPostFeedbackContent(leadId), _feedbackData.toJson(),
        withToken: true);
    add(FeedbackEvents.FEEDBACK_UPLOADED);
  }

  void updateRating(double rating) {
    _feedbackData.rating = rating;
  }

  void updateReview(String msg) {
    _feedbackData.review = msg;
    add(FeedbackEvents.UPDATE_REVIEW_MSG);
  }

  void updateFeedbackOptions(String question, String answer, int index) {
    UsersFeedback feedback = UsersFeedback(question: question, answer: answer);
    try {
      _feedbackData.userFeedback.removeAt(index);
    } catch (err) {}
    _feedbackData.userFeedback.insert(index, feedback);
    add(FeedbackEvents.UPDATE_FEEDBACK_OPTIONS);
    print(_feedbackData.userFeedback[0].answer);
  }
}
