class Result {
  Result(
      {required this.formattedAddress,
      required this.icon,
      required this.internationalPhoneNumber,
      required this.name,
      required this.placeId,
      required this.rating,
      required this.vicinity,
      required this.photos,
      required this.reviews
      // required this.photourl,
      });

  late final String formattedAddress;
  late final String formattedPhoneNumber;
  late final Geometry geometry;
  late final String icon;
  late final List<Photos> photos;
  late final String internationalPhoneNumber;
  late final String name;
  late final OpeningHours openingHours;
  late final List<Reviews> reviews;
  late final String placeId;
  late final String rating;

  late final String vicinity;

  Result.fromJson(Map<String, dynamic> json) {
    formattedAddress = json['formatted_address'];
    formattedPhoneNumber = json['formatted_phone_number'];
    geometry = Geometry.fromJson(json['geometry']);
    icon = json['icon'];
    //photos = List.from(json['photos']).map((e)=>Photos.fromJson(e)).toList();
    if (json['photos'] != null) {
      photos = <Photos>[];
      json['photos'].forEach((v) {
        photos.add(Photos.fromJson(v));
      });
    }
    if (json['reviews'] != null) {
      photos = <Photos>[];
      json['reviews'].forEach((v) {
        photos.add(Photos.fromJson(v));
      });
    }

    internationalPhoneNumber = json['international_phone_number'];
    name = json['name'];
    openingHours = OpeningHours.fromJson(json['opening_hours']);
    placeId = json['place_id'];

    rating = json['rating'].toString();

    vicinity = json['vicinity'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['photos'] = photos.map((v) => v.toJson()).toList();
    _data['formatted_address'] = formattedAddress;
    _data['formatted_phone_number'] = formattedPhoneNumber;
    _data['geometry'] = geometry.toJson();
    _data['icon'] = icon;
    _data['international_phone_number'] = internationalPhoneNumber;
    _data['name'] = name;
    _data['opening_hours'] = openingHours.toJson();
    _data['place_id'] = placeId;
    _data['rating'] = rating;
    _data['vicinity'] = vicinity;
    return _data;
  }
}

class Geometry {
  Geometry({
    required this.location,
    required this.viewport,
  });
  late final Location location;
  late final Viewport viewport;

  Geometry.fromJson(Map<String, dynamic> json) {
    location = Location.fromJson(json['location']);
    viewport = Viewport.fromJson(json['viewport']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['location'] = location.toJson();
    _data['viewport'] = viewport.toJson();
    return _data;
  }
}

class Location {
  Location({
    required this.lat,
    required this.lng,
  });
  late final double lat;
  late final double lng;

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['lat'] = lat;
    _data['lng'] = lng;
    return _data;
  }
}

class Viewport {
  Viewport({
    required this.northeast,
    required this.southwest,
  });
  late final Northeast northeast;
  late final Southwest southwest;

  Viewport.fromJson(Map<String, dynamic> json) {
    northeast = Northeast.fromJson(json['northeast']);
    southwest = Southwest.fromJson(json['southwest']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['northeast'] = northeast.toJson();
    _data['southwest'] = southwest.toJson();
    return _data;
  }
}

class Northeast {
  Northeast({
    required this.lat,
    required this.lng,
  });
  late final double lat;
  late final double lng;

  Northeast.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['lat'] = lat;
    _data['lng'] = lng;
    return _data;
  }
}

class Southwest {
  Southwest({
    required this.lat,
    required this.lng,
  });
  late final double lat;
  late final double lng;

  Southwest.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['lat'] = lat;
    _data['lng'] = lng;
    return _data;
  }
}

class OpeningHours {
  OpeningHours({
    required this.openNow,
    //required this.periods,
    //required this.weekdayText,
  });
  late final bool openNow;
  late final List<Periods> periods;
  late final List<String> weekdayText;

  OpeningHours.fromJson(Map<String, dynamic> json) {
    openNow = json['open_now'];
    periods =
        List.from(json['periods']).map((e) => Periods.fromJson(e)).toList();
    weekdayText = List.castFrom<dynamic, String>(json['weekday_text']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['open_now'] = openNow;
    _data['periods'] = periods.map((e) => e.toJson()).toList();
    _data['weekday_text'] = weekdayText;
    return _data;
  }
}

class Periods {
  Periods({
    required this.close,
    required this.open,
  });
  late final Close close;
  late final Open open;

  Periods.fromJson(Map<String, dynamic> json) {
    close = Close.fromJson(json['close']);
    open = Open.fromJson(json['open']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['close'] = close.toJson();
    _data['open'] = open.toJson();
    return _data;
  }
}

class Close {
  Close({
    required this.day,
    required this.time,
  });
  late final int day;
  late final String time;

  Close.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['day'] = day;
    _data['time'] = time;
    return _data;
  }
}

class Open {
  Open({
    required this.day,
    required this.time,
  });
  late final int day;
  late final String time;

  Open.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['day'] = day;
    _data['time'] = time;
    return _data;
  }
}

class Photos {
  Photos({
    required this.height,
    required this.htmlAttributions,
    required this.photoReference,
    required this.width,
  });
  late final int height;
  late final List<String> htmlAttributions;
  late final String photoReference;
  late final int width;

  Photos.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    htmlAttributions =
        List.castFrom<dynamic, String>(json['html_attributions']);
    photoReference = json['photo_reference'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['height'] = height;
    _data['html_attributions'] = htmlAttributions;
    _data['photo_reference'] = photoReference;
    _data['width'] = width;
    return _data;
  }
}

class PlusCode {
  PlusCode({
    required this.compoundCode,
    required this.globalCode,
  });
  late final String compoundCode;
  late final String globalCode;

  PlusCode.fromJson(Map<String, dynamic> json) {
    compoundCode = json['compound_code'];
    globalCode = json['global_code'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['compound_code'] = compoundCode;
    _data['global_code'] = globalCode;
    return _data;
  }
}

class Reviews {
  Reviews({
    required this.authorName,
    //required this.authorUrl,
    // required this.language,
    // required this.profilePhotoUrl,
    required this.rating,
    //required this.relativeTimeDescription,
    required this.text,
    //required this.time,
  });
  late final String authorName;
  late final String authorUrl;
  late final String language;
  late final String profilePhotoUrl;
  late final String rating;
  late final String relativeTimeDescription;
  late final String text;
  late final int time;

  Reviews.fromJson(Map<String, dynamic> json) {
    authorName = json['author_name'];
    authorUrl = json['author_url'];
    language = json['language'];
    profilePhotoUrl = json['profile_photo_url'];
    rating = json['rating'].toString();
    relativeTimeDescription = json['relative_time_description'];
    text = json['text'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['author_name'] = authorName;
    _data['author_url'] = authorUrl;
    _data['language'] = language;
    _data['profile_photo_url'] = profilePhotoUrl;
    _data['rating'] = rating;
    _data['relative_time_description'] = relativeTimeDescription;
    _data['text'] = text;
    _data['time'] = time;
    return _data;
  }
}
