import 'package:the_pet_nest/bookings/feedback/model/feedbackInternalModel.dart';

class FeedbackState {
  final bool loading;
  final bool feedbackExists;
  final bool feedbackUpdated;
  final FeedbackInternalModel? feedbackData;
  final bool updatingFeedback;

  FeedbackState({
    this.loading = true,
    this.feedbackData,
    this.feedbackExists = false,
    this.feedbackUpdated = false,
    this.updatingFeedback = false,
  });

  FeedbackState copyWith(
      {bool? loading,
      FeedbackInternalModel? feedbackData,
      bool? feedbackUpdated,
      bool? feedbackExists,
      bool? updatingFeedback}) {
    return FeedbackState(
        loading: loading ?? this.loading,
        feedbackData: feedbackData ?? this.feedbackData,
        feedbackExists: feedbackExists ?? this.feedbackExists,
        feedbackUpdated: feedbackUpdated ?? this.feedbackUpdated,
        updatingFeedback: updatingFeedback ?? this.updatingFeedback);
  }
}
