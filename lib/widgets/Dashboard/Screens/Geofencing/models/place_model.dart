import 'package:profit/widgets/Dashboard/Screens/Geofencing/models/newdetails.dart';

class PlaceDetail {
  String icon;
  String id;
  String name;
  String rating;
  String vicinity;

  String? formattedAddress;
  String? international_phone_number;
  List<Photos>? gymphoto;
  List<String>? weekday_text;

  PlaceDetail(this.id, this.name, this.icon, this.rating,
      this.vicinity, //this.gymphoto,
      [this.formattedAddress,
      this.international_phone_number,
      this.weekday_text]);
}
