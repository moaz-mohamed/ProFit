import 'package:flutter/material.dart';
import 'package:profit/design/ThemeUI.dart';
import 'package:profit/models/radio_item.dart';

class CustomRadioActivity extends StatefulWidget {
  const CustomRadioActivity({
    required this.onSelect,
  });

  final Function(double workModel) onSelect;

  @override
  createState() {
    return CustomRadioState();
  }
}

class CustomRadioState extends State<CustomRadioActivity> {
  List<RadioItem> sampleData = [];

  @override
  void initState() {
    super.initState();
    sampleData.add(RadioItem(
      false,
      1.2,
      'Sedentary: Little or no excerise, desk job',
    ));
    sampleData
        .add(RadioItem(false, 1.375, 'Lightly Active: sports 1-3 days/week'));
    sampleData
        .add(RadioItem(false, 1.55, 'Moderately Active ,sports 6-7 days/week'));
    sampleData
        .add(RadioItem(false, 1.725, 'Very Active: Hard excerise everyday'));
    sampleData.add(
        RadioItem(false, 1.9, 'Extra Active: Hard excerise 2 or more/day'));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Text(
          "How active are you ?",
          style: FitnessAppTheme.headlineBlue,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 52.7),
          child: Column(
            children: sampleData
                .map(
                  (e) => InkWell(
                    highlightColor: FitnessAppTheme.nearlyBlue,
                    focusColor: FitnessAppTheme.nearlyBlue,
                    splashColor: FitnessAppTheme.nearlyBlue,
                    onTap: () {
                      setState(() {
                        sampleData
                            .forEach((element) => element.isSelected = false);
                        e.isSelected = true;
                      });
                      widget.onSelect(e.valueForCalculation);
                    },
                    child: _RadioItem(e),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

class _RadioItem extends StatelessWidget {
  final RadioItem _item;
  const _RadioItem(this._item);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 0),
            child: Container(
              height: 25.0,
              width: 25.0,
              child: Center(
                child: Icon(Icons.check,
                    color: _item.isSelected ? Colors.white : Colors.black,
                    size: 18.0),
              ),
              decoration: BoxDecoration(
                color: _item.isSelected
                    ? FitnessAppTheme.nearlyBlue
                    : Colors.transparent,
                border: Border.all(
                    width: 1.0,
                    color: _item.isSelected
                        ? FitnessAppTheme.nearlyBlue
                        : Colors.grey),
                borderRadius: const BorderRadius.all(Radius.circular(2.0)),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10.0),
            child: Column(children: [
              Text(
                _item.text,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.03),
              )
            ]),
          )
        ],
      ),
    );
  }
}
