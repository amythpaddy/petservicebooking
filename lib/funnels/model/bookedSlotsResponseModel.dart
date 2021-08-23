class BookedSlotsResponse {
  bool? success;
  Response? response;

  BookedSlotsResponse({this.success, this.response});

  BookedSlotsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.response != null) {
      data['response'] = this.response!.toJson();
    }
    return data;
  }
}

class Response {
  List<String>? bookedSlots;

  Response({this.bookedSlots});

  Response.fromJson(Map<String, dynamic> json) {
    bookedSlots = json['booked_slots'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booked_slots'] = this.bookedSlots;
    return data;
  }
}
