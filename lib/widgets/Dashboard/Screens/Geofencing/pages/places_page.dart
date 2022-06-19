import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:location/location.dart';
import '../models/place_model.dart';
import '../services/gplace_service.dart';
import 'placedetail.dart';

class PlacesPage extends StatefulWidget {
  const PlacesPage({Key? key}) : super(key: key);

  @override
  State createState() => Placestate();
}

class Placestate extends State<PlacesPage> {
  String? _currentPlaceId;
  List<PlaceDetail>? _places;
  late VoidCallback onItemTapped;

  handleItemTap(PlaceDetail place) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => PlaceDetailPage(place.id)));
  }

  Future<List<PlaceDetail>> _requestNearbyPlaces() async {
    LocationData? locData;

    try {
      LocationService locationService = LocationService.get();
      locData = await Location().getLocation();
      List<String> pos = await locationService.getNearbyPlaces(locData);
      return await locationService.getPlaceList(pos);
    } catch (error) {
      print("can't get location");
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    if (_places == null) {
      _requestNearbyPlaces().then((data) {
        setState(() {
          _places = data;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    onItemTapped = () => Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) =>
            PlaceDetailPage(_currentPlaceId ?? "")));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Gyms'),
      ),
      body: _createContent(),
    );
  }

  final String gymPhoto = "assets/Geofencing/gym.png";

  Widget _createContent() {
    if (_places == null || _places!.isEmpty) {
      return const Center(
        child: SizedBox(
          width: 100,
          height: 100,
          child: LoadingIndicator(
            indicatorType: Indicator.ballClipRotateMultiple,
            colors: [Colors.blue],
          ),
        ),
      );
    } else {
      return ListView(
        children: _places!.map((f) {
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 7,
              child: ListTile(
                  title: Text(f.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "SourceSansPro",
                          fontSize: 18.0,
                          color: Colors.blue)),
                  leading: Image.asset(gymPhoto),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 2, vertical: 2),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              RatingBarIndicator(
                                rating: double.parse(f.rating),
                                itemBuilder: (context, index) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemCount: 5,
                                itemSize: 20.0,
                                direction: Axis.horizontal,
                              ),
                              Text(" " + f.rating.toString()),
                            ],
                          ),
                          padding: const EdgeInsets.all(2)),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(f.vicinity),
                      ),
                    ],
                  ),
                  onTap: () {
                    _currentPlaceId = f.id;
                    handleItemTap(f);
                  }),
            ),
          );
        }).toList(),
      );
    }
  }
}
