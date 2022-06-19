import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:profit/widgets/Dashboard/Screens/Geofencing/models/newdetails.dart';
import '../models/place_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:profit/widgets/Dashboard/Screens/Geofencing/constants.dart'
    as constants;

class LocationService {
  String key = constants.googleKey;
  static final _locationService = LocationService();

  static LocationService get() {
    return _locationService;
  }

  Future getNearbyPlaces(LocationData loc) async {
    String longitude = loc.longitude.toString();
    String latitude = loc.latitude.toString();
    List<String> pos = [longitude, latitude];
    return pos;
  }

  String buildPhotoURL(String photoReference) {
    return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=$photoReference&key=$key";
  }

  Future<List<PlaceDetail>> getPlaceList(List<String> pos) async {
    String longitude = pos[0];
    String latitude = pos[1];
    final String url =
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?keyword=gym&location=${latitude}%2C$longitude&rankby=distance&key=$key";

    var reponse =
        await http.get(Uri.parse(url), headers: {"Accept": "application/json"});
    var data = json.decode(reponse.body)["results"];

    var places = <PlaceDetail>[];
    data.forEach((f) => places.add(PlaceDetail(
          f["place_id"],
          f["name"],
          f["icon"],
          f["rating"].toString(),
          f["vicinity"],
        )));

    return places;
  }

  Future getPlace(String placeId) async {
    String key2 = constants.googleKey;
    String detailUrl =
        "https://maps.googleapis.com/maps/api/place/details/json?fields=&key=${key2}&place_id=";
    var response = await http.get(Uri.parse(detailUrl + placeId),
        headers: {"Accept": "application/json"});
    var result = json.decode(response.body)["result"];
    List<dynamic> data = result["photos"] ?? [];
    List<Photos> listphotos = [];
    List<dynamic> dataReview = result["reviews"] ?? [];
    List<Reviews> listreviews = [];

    for (int i = 0; i < data.length; i++) {
      listphotos.add(Photos.fromJson(data[i]));
    }

    for (int i = 0; i < dataReview.length; i++) {
      listreviews.add(Reviews.fromJson(dataReview[i]));
    }

    return Result(
        formattedAddress: result["formatted_address"] ?? "",
        icon: result["icon"] ?? "",
        internationalPhoneNumber: result["international_phone_number"] ?? "",
        name: result["name"] ?? "",
        placeId: result["place_id"] ?? "",
        rating: result["rating"] == null ? "" : result["rating"].toString(),
        vicinity: result["vicinity"] ?? "",
        photos: listphotos,
        reviews: listreviews);
  }
}
