class FeedbackOptionResponseModel {
  _Data? data;

  FeedbackOptionResponseModel({this.data});

  FeedbackOptionResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new _Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class _Data {
  _OrderFeedback? orderFeedback;

  _Data({this.orderFeedback});

  _Data.fromJson(Map<String, dynamic> json) {
    orderFeedback = json['order_feedback'] != null
        ? new _OrderFeedback.fromJson(json['order_feedback'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orderFeedback != null) {
      data['order_feedback'] = this.orderFeedback!.toJson();
    }
    return data;
  }
}

class _OrderFeedback {
  int? id;
  int? rating;
  String? review;
  List<_OrderFeedbackReplies>? orderFeedbackReplies;

  _OrderFeedback(
      {this.id, this.rating, this.review, this.orderFeedbackReplies});

  _OrderFeedback.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rating = json['rating'];
    review = json['review'];
    if (json['order_feedback_replies'] != null) {
      orderFeedbackReplies = [];
      json['order_feedback_replies'].forEach((v) {
        orderFeedbackReplies!.add(new _OrderFeedbackReplies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rating'] = this.rating;
    data['review'] = this.review;
    if (this.orderFeedbackReplies != null) {
      data['order_feedback_replies'] =
          this.orderFeedbackReplies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class _OrderFeedbackReplies {
  String? feedbackQuestion;
  String? selectedFeedbackOption;

  _OrderFeedbackReplies({this.feedbackQuestion, this.selectedFeedbackOption});

  _OrderFeedbackReplies.fromJson(Map<String, dynamic> json) {
    feedbackQuestion = json['feedback_question'];
    selectedFeedbackOption = json['selected_feedback_option'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['feedback_question'] = this.feedbackQuestion;
    data['selected_feedback_option'] = this.selectedFeedbackOption;
    return data;
  }
}
