import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_pet_nest/bookings/feedback/bloc/feedbackEvent.dart';
import 'package:the_pet_nest/bookings/feedback/bloc/feedbackState.dart';
import 'package:the_pet_nest/bookings/feedback/model/feedbackOptionModel.dart';
import 'package:the_pet_nest/konstants/endpoints.dart';
import 'package:the_pet_nest/utils/ApiCaller.dart';

class FeedbackBloc extends Bloc<FeedbackEvents, FeedbackState> {
  FeedbackBloc({required FeedbackState initialState, required this.leadId})
      : super(initialState) {
    getFeedbackOptionData(this.leadId);
  }
  final String leadId;
  FeedbackData? _feedbackData;

  @override
  Stream<FeedbackState> mapEventToState(FeedbackEvents event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }

  void getFeedbackOptionData(String leadId) async {
    print(kUrlGetFeedbackContent(leadId));
    var response =
        await ApiCaller.get(kUrlGetFeedbackContent(leadId), withToken: true);
    _feedbackData = FeedbackOptionResponseModel.fromJson(response).data;
    add(FeedbackEvents.FEEDBACK_FETCHED);
  }

  void sendFeedback(int leadId) async {
    var data;
    var response = await ApiCaller.post(
        kUrlPostFeedbackContent(leadId.toString()), data,
        withToken: true);
    _feedbackData = FeedbackOptionResponseModel.fromJson(response).data;
    add(FeedbackEvents.FEEDBACK_FETCHED);
  }
}
