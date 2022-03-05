import 'package:flutter/material.dart';

class GeoFencing extends StatelessWidget {
  const GeoFencing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment
          .center, // Align however you like (i.e .centerRight, centerLeft)
      child: Text("Geofencing screen"),
    );
  }
}
