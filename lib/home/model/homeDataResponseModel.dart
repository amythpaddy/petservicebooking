class HomeDataResponseModel {
  HomeDataModel? data;

  HomeDataResponseModel({this.data});

  HomeDataResponseModel.fromJson(Map<String, dynamic> json) {
    data =
        json['data'] != null ? new HomeDataModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class HomeDataModel {
  List<_Banners>? banners;
  List<_Reviews>? reviews;
  List<_Partners>? partners;

  HomeDataModel({this.banners, this.reviews, this.partners});

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null) {
      banners = [];
      json['banners'].forEach((v) {
        banners!.add(new _Banners.fromJson(v));
      });
    }
    if (json['reviews'] != null) {
      reviews = [];
      json['reviews'].forEach((v) {
        reviews!.add(new _Reviews.fromJson(v));
      });
    }
    if (json['partners'] != null) {
      partners = [];
      json['partners'].forEach((v) {
        partners!.add(new _Partners.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.banners != null) {
      data['banners'] = this.banners!.map((v) => v.toJson()).toList();
    }
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    if (this.partners != null) {
      data['partners'] = this.partners!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class _Banners {
  String? ctaText;
  String? ctaUrl;
  String? text;
  String? image;

  _Banners({this.ctaText, this.ctaUrl, this.text, this.image});

  _Banners.fromJson(Map<String, dynamic> json) {
    ctaText = json['cta_text'];
    ctaUrl = json['cta_url'];
    text = json['text'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cta_text'] = this.ctaText;
    data['cta_url'] = this.ctaUrl;
    data['text'] = this.text;
    data['image'] = this.image;
    return data;
  }
}

class _Reviews {
  double? rating;
  String? feedback;
  _User? user;
  String? reviewedAt;

  _Reviews({this.rating, this.feedback, this.user, this.reviewedAt});

  _Reviews.fromJson(Map<String, dynamic> json) {
    rating = double.parse(json['rating'].toString());
    feedback = json['feedback'];
    user = json['user'] != null ? new _User.fromJson(json['user']) : null;
    reviewedAt = json['reviewed_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rating'] = this.rating;
    data['feedback'] = this.feedback;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['reviewed_at'] = this.reviewedAt;
    return data;
  }
}

class _User {
  String? firstName;

  _User({this.firstName});

  _User.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    return data;
  }
}

class _Partners {
  int? id;
  String? fullName;
  String? partnerType;
  double? rating;
  int? jobsCount;

  _Partners(
      {this.id, this.fullName, this.partnerType, this.rating, this.jobsCount});

  _Partners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    partnerType = json['partner_type'];
    rating = json['rating'];
    jobsCount = json['jobs_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['partner_type'] = this.partnerType;
    data['rating'] = this.rating;
    data['jobs_count'] = this.jobsCount;
    return data;
  }
}
