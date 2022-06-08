import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:profit/widgets/Dashboard/Screens/Geofencing/models/newdetails.dart';
import '../services/gplace_service.dart';
import 'package:profit/widgets/Dashboard/Screens/Geofencing/constants.dart'
    as Constants;

class PlaceDetailPage extends StatefulWidget {
  String? _place_id;
  PlaceDetailPage(this._place_id, {Key? key}) : super(key: key);
  @override
  State createState() => PlaceDetailState();
}

class PlaceDetailState extends State<PlaceDetailPage> {
  String key = Constants.googleKey;
  List<Photos> ph = [];

  @override
  Widget build(BuildContext context) {
    if (_place == null) {
      return Material(
          color: Colors.blueAccent,
          child: Scaffold(
              appBar: AppBar(
                title: const Text("Loading..."),
                backgroundColor: Colors.blue,
              ),
              body: const Center(
                  child: Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: LoadingIndicator(
                    indicatorType: Indicator.ballClipRotateMultiple,
                    colors: [Colors.blue],
                  ),
                ),
              ))));
    }
    return Material(
        color: Colors.blueAccent,
        child: Scaffold(
            appBar: AppBar(
              title: Text(_place!.name),
              backgroundColor: Colors.blue,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    if (!_place!.formattedAddress.isEmpty)
                      addressCard("Address ", _place!.formattedAddress,
                          Icons.location_on),
                    if (!_place!.rating.isEmpty)
                      // getCard("Rating ", _place!.rating, Icons.star_rate),
                      ratingCard("Rating ", Icons.star_rate),
                    if (!_place!.internationalPhoneNumber.isEmpty)
                      addressCard("Phone ", _place!.internationalPhoneNumber,
                          Icons.phone),
                    if (!_place!.reviews.isEmpty)
                      listCard("Reviews ", Icons.comment, buildreviews()),
                    if (!_place!.photos.isEmpty)
                      listCard("Photos ", Icons.image, buildPhotos()),
                  ],
                ),
              ),
            )));
  }

  Result? _place;

  @override
  void initState() {
    super.initState();
    LocationService.get()
        .getPlace(widget._place_id ?? "ChIJv3c4jz-uEmsRNQT_5kJNMG8")
        .then((data) {
      setState(() {
        _place = data;
      });
    });
  }

  ListView buildPhotos() {
    List<Widget> list = [];
    list.add(SizedBox(
        height: 100.0,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _place!.photos.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: SizedBox(
                    height: 100,
                    child: GestureDetector(
                      onTap: () async {
                        await showDialog(
                            context: context,
                            builder: (_) => imageDialog(
                                'My Image',
                                buildPhotoURL(
                                    _place!.photos[index].photoReference),
                                context));
                      },
                      child: Image.network(
                        buildPhotoURL(_place!.photos[index].photoReference),
                      ),
                    ),
                  ));
            })));
    ;

    return ListView(
      shrinkWrap: true,
      children: list,
    );
  }

  ListView buildreviews() {
    List<Widget> list = [];
    list.add(SizedBox(
        height: 150,
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: _place!.reviews.length,
            itemBuilder: (context, index) {
              return Card(
                shape: RoundedRectangleBorder(
                  //side: BorderSide(color: Colors.blueGrey, width: 1),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: ListTile(
                  title: Text(
                    _place!.reviews[index].authorName,
                    style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                  leading:
                      Image.network(_place!.reviews[index].profilePhotoUrl),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_place!.reviews[index].text),
                    ],
                  ),
                ),
              );
            })));

    return ListView(
      shrinkWrap: true,
      children: list,
    );
  }

  String buildPhotoURL(String photoReference) {
    return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${photoReference}&key=${key}";
  }

  addressCard(String header, String content, IconData iconData) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.blue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(header,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0)),
                Icon(
                  iconData,
                  color: Colors.white,
                )
              ],
            ),
            const SizedBox(height: 12),
            Text(
              content,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  ratingCard(String header, IconData iconData) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.blue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(header,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0)),
                Icon(
                  iconData,
                  color: Colors.white,
                )
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                RatingBarIndicator(
                  rating: double.parse(_place!.rating),
                  itemBuilder: (context, index) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 30.0,
                  direction: Axis.horizontal,
                ),
                Text(" " + _place!.rating.toString(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  listCard(String header, IconData iconData, ListView listView) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.blue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(header,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0)),
                Icon(
                  iconData,
                  color: Colors.white,
                )
              ],
            ),
            const SizedBox(height: 10),
            listView,
          ],
        ),
      ),
    );
  }

  Widget imageDialog(text, path, context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
          ),
          SizedBox(
            width: 220,
            height: 200,
            child: Image.network(
              '$path',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
