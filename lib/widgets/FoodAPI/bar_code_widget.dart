import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:profit/bloc/barcode/bar_item_bloc.dart';
import 'package:profit/bloc/barcode/bar_item_event.dart';
import 'package:profit/bloc/barcode/bar_item_state.dart';
import 'package:profit/bloc/postapi/post_food_item_bloc.dart';
import 'package:profit/models/food_data_model.dart';

import 'AddFoodScreen.dart';

class BarCodeSearch extends StatefulWidget {
  BarCodeBloc barcodebloc;
  final int foodtype;

  BarCodeSearch({required this.barcodebloc, required this.foodtype});

  @override
  State<BarCodeSearch> createState() => _BarCodeSearchState();
}

class _BarCodeSearchState extends State<BarCodeSearch> {
  late Items items;
  List<Hints> allHintsItems = [];
  late String _barcodeScanResult = "Unknown UPC";

  void initState() {
    super.initState();
    scanBarcode();
  }

  Future<void> scanBarcode() async {
    String thisScanResult;
    try {
      thisScanResult = await FlutterBarcodeScanner.scanBarcode(
          '#ff0000', "Cancel scan", true, ScanMode.BARCODE);
    } on PlatformException {
      thisScanResult = "Failed to get platform version";
    }
    setState(() {
      _barcodeScanResult = thisScanResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    widget.barcodebloc.add(FetchBarCodeItem(barcode: _barcodeScanResult));
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<BarCodeBloc, BarCodeState>(
        builder: (BuildContext context, BarCodeState state) {
          if (state is BarCodeLoaded) {
            items = (state).items;
            allHintsItems = items.hints;
            if (state.items.hints.isEmpty) {
              return const Center(
                child: Text('No Results'),
              );
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  margin: const EdgeInsets.all(20.0),
                  child: InkWell(
                    child: ListTile(
                      leading: const Icon(Icons.food_bank_outlined),
                      title: Text(
                        state.items.hints[index].food.label,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey),
                      ),
                      subtitle: Text(state
                          .items.hints[index].food.nutrients.ENERCKCAL
                          .toString()),
                      trailing: const Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddFoodScreen(
                              calculateFoodBloc:
                                  BlocProvider.of<CalculateFoodBloc>(context),
                              foodLabel: items.hints[index].food.label,
                              foodID: items.hints[index].food.foodId,
                              foodtype: widget.foodtype,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );

                //Text(state.recipes[index].title);
              },
              itemCount: allHintsItems.length,
            );
          } else if (state is BarCodeInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BarCodeLoadedError) {
            return const Center(
              child: Text('Failed To Load'),
            );
          }
          ;
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
