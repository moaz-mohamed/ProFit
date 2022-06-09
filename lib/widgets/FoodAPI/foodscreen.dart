import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:profit/bloc/barcode/bar_item_bloc.dart';
import 'package:profit/bloc/search/search_bloc.dart';
import 'package:profit/widgets/FoodAPI/bar_code_widget.dart';
import 'package:profit/widgets/FoodAPI/search_food.dart';

class FoodScreen extends StatefulWidget {
  final int foodtype;
  const FoodScreen({Key? key, required this.foodtype}) : super(key: key);

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  @override
  Widget build(BuildContext foodScreenContext) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Search'),
          backgroundColor: Colors.blueAccent,
          actions: [
            IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  showSearch(
                    context: foodScreenContext,
                    delegate: FoodSearch(
                        searchBloc: BlocProvider.of<SearchBloc>(context),
                        foodtype: widget.foodtype),
                  );
                }),
            IconButton(
                icon: const Icon(Icons.qr_code_scanner),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BarCodeSearch(
                        barcodebloc: BlocProvider.of<BarCodeBloc>(context),
                        foodtype: widget.foodtype,
                      ),
                    ),
                  );
                }),
          ],
        ),
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        'assets/Food/food.png',
                        width: 200,
                      ),
                    ),
                    const Text(
                      "Search for Food",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                          fontFamily: 'SourceSansPro',
                          color: Colors.blue),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(
                    'assets/Attributions/Edamam_Badge_White.png',
                    width: 200,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
