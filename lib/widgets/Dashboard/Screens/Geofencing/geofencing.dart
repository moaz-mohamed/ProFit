import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nice_buttons/nice_buttons.dart';
import 'pages/places_page.dart';

class Geofencing extends StatelessWidget {
  final String photo =
      "https://cdn.iconscout.com/icon/free/png-256/gym-location-1-1147899.png";
  final String googleAttribution =
      "https://johnmeade-webdev.github.io/bookFinder/public/Powered_by_google.png";

  const Geofencing({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(alignment: Alignment.center, children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Image.network(
                      photo,
                      width: 150,
                      height: 150,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: NiceButtons(
                    stretch: false,
                    progress: true,
                    startColor: Colors.lightBlue,
                    gradientOrientation: GradientOrientation.Vertical,
                    onTap: (finish) {
                      Timer(const Duration(seconds: 1), () {
                        finish();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PlacesPage()),
                        );
                      });
                    },
                    child: const Text("Check Nearby Gyms",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            fontFamily: 'SourceSansPro',
                            color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.network(
              googleAttribution,
              width: 200,
            ),
          ),
        ),
      ]),
    );
  }
}
