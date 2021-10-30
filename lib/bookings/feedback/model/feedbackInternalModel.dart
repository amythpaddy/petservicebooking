class FeedbackInternalModel {
  double rating = 0;
  String review = "";
  List<UsersFeedback> userFeedback = [];
  List<AvailableQuestionList> userQuestions = [];
  FeedbackInternalModel();

  FeedbackInternalModel.fromQuestionsList(Map<String, dynamic> response) {
    response["data"].forEach((v) {
      userQuestions.add(AvailableQuestionList.fromJson(v));
    });
  }

  FeedbackInternalModel.fromSavedFeedback(Map<String, dynamic> response) {
    if (response["data"]["order_feedback"] != null) {
      Map<String, dynamic> orderFeedback = response["data"]["order_feedback"];
      rating = orderFeedback["rating"];
      review = orderFeedback["review"];
      if (orderFeedback["order_feedback_replies_attributes"] != null)
        orderFeedback["order_feedback_replies_attributes"].forEach((v) {
          userFeedback.add(UsersFeedback.fromJson(v));
        });
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> orderFeedbackReplies = Map();
    orderFeedbackReplies["order_feedback_replies"] =
        this.userFeedback.map((e) => e.toJson()).toList();
    Map<String, dynamic> orderFeedback = Map();
    orderFeedback["rating"] = rating;
    orderFeedback["review"] = review;
    orderFeedback["order_feedback_replies_attributes"] = orderFeedbackReplies;
    Map<String, dynamic> data = Map();
    data["order_feedback"] = orderFeedback;
    return data;
  }
}

class UsersFeedback {
  String question = "";
  String answer = "";
  UsersFeedback({required this.question, required this.answer});
  UsersFeedback.fromJson(Map<String, dynamic> json) {
    question = json["feedback_question"];
    answer = json["selected_feedback_option"];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> userFeedback = Map();
    userFeedback["feedback_question"] = question;
    userFeedback["selected_feedback_option"] = answer;
    return userFeedback;
  }
}

class AvailableQuestionList {
  String question = "";
  int questionId = 0;
  List<Options> options = [];

  AvailableQuestionList.fromJson(Map<String, dynamic> json) {
    question = json["question"];
    questionId = json["id"];
    json["options"].forEach((v) {
      options.add(Options.fromJson(v));
    });
  }
}

class Options {
  String value = "";
  int id = 0;
  Options.fromJson(Map<String, dynamic> json) {
    value = json["value"];
    id = json["id"];
  }
}
