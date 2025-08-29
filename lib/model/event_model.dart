class EventModel {
  bool? success;
  String? message;
  Data? data;

  EventModel({this.success, this.message, this.data});

  EventModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Events>? events;
  int? total;

  Data({this.events, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['events'] != null) {
      events = <Events>[];
      json['events'].forEach((v) {
        events!.add(Events.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (events != null) {
      data['events'] = events!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    return data;
  }
}

class Events {
  int? eventId;
  String? eventName;
  String? description;
  String? eventProfilePic;
  String? eventProfileImg;
  String? eventUrl;
  int? eventPriceFrom;
  int? eventPriceTo;
  String? readableFromDate;
  String? readableToDate;
  bool? isFavourite;
  String? city;
  String? country;
  List<String>? keywords;
  List<DanceStyles>? danceStyles;
  int? eventDateId;

  Events({
    this.eventId,
    this.eventName,
    this.description,
    this.eventProfilePic,
    this.eventProfileImg,
    this.eventUrl,
    this.eventPriceFrom,
    this.eventPriceTo,
    this.readableFromDate,
    this.readableToDate,
    this.isFavourite,
    this.city,
    this.country,
    this.keywords,
    this.danceStyles,
    this.eventDateId,
  });

  Events.fromJson(Map<String, dynamic> json) {
    eventId = json['event_id'];
    eventName = json['event_name'];
    description = json['description'];
    eventProfilePic = json['event_profile_pic'];
    eventProfileImg = json['event_profile_img'];
    eventUrl = json['event_url'];
    eventPriceFrom = json['event_price_from'];
    eventPriceTo = json['event_price_to'];
    readableFromDate = json['readable_from_date'];
    readableToDate = json['readable_to_date'];
    isFavourite = json['isFavorite'] == 1;
    city = json['city'];
    country = json['country'];
    keywords = json['keywords'] != null ? List<String>.from(json['keywords']) : [];
    if (json['danceStyles'] != null) {
      danceStyles = <DanceStyles>[];
      json['danceStyles'].forEach((v) {
        danceStyles!.add(DanceStyles.fromJson(v));
      });
    }
    eventDateId = json['event_date_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['event_id'] = eventId;
    data['event_name'] = eventName;
    data['description'] = description;
    data['event_profile_pic'] = eventProfilePic;
    data['event_profile_img'] = eventProfileImg;
    data['event_url'] = eventUrl;
    data['event_price_from'] = eventPriceFrom;
    data['event_price_to'] = eventPriceTo;
    data['readable_from_date'] = readableFromDate;
    data['readable_to_date'] = readableToDate;
    data['isFavorite'] = isFavourite == true ? 1 : 0;
    data['city'] = city;
    data['country'] = country;
    data['keywords'] = keywords;
    if (danceStyles != null) {
      data['danceStyles'] = danceStyles!.map((v) => v.toJson()).toList();
    }
    data['event_date_id'] = eventDateId;
    return data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Events && other.eventId == eventId;
  }

  @override
  int get hashCode => eventId.hashCode;
}

class DanceStyles {
  int? dsId;
  String? dsName;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  DanceStyles({this.dsId, this.dsName, this.createdAt, this.updatedAt, this.deletedAt});

  DanceStyles.fromJson(Map<String, dynamic> json) {
    dsId = json['ds_id'];
    dsName = json['ds_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['ds_id'] = dsId;
    data['ds_name'] = dsName;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
