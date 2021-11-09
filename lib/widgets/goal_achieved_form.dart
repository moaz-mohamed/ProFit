import 'package:flutter/material.dart';
import 'package:profit/design/ThemeUI.dart';
import 'package:profit/models/user_data.dart';

class GoalAchievedForm extends StatefulWidget {
  const GoalAchievedForm({Key? key, required this.onComplete})
      : super(key: key);

  final Function(int futureWorkModel) onComplete;

  @override
  createState() {
    return GoalAchievedFormState();
  }
}

class GoalAchievedFormState extends State<GoalAchievedForm> {
  List<UserModel> dataModels = <UserModel>[];
  int goalAchieved = 1;

  @override
  void initState() {
    super.initState();
    _initializeData(); //It is the home default screen where he initially selects the first model as default
  }

  void _initializeData() {
    dataModels.add(
      UserModel(
        true,
        1,
        "lose",
        "Lose Weight",
        "Be slim lose weight",
        20,
      ),
    );
    dataModels.add(
      UserModel(
        false,
        2,
        "maintain",
        "Maintain Weight ",
        "Be healthy ",
        5,
      ),
    );
    dataModels.add(
      UserModel(
        false,
        3,
        "muscle",
        "Gain Weight",
        "Build muscle ",
        20,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("ProFit"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0).copyWith(left: 25.0, right: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: const [
                Text(
                  "Goal Achieved",
                  style: FitnessAppTheme.headlineBlue,
                ),
                Text(
                  "Choose your goal to achieve",
                  style: FitnessAppTheme.subtitle,
                ),
              ],
            ),
            Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: ListView.builder(
                    itemCount: dataModels.length,
                    itemBuilder: (BuildContext context, int index) {
                      //converts each item to widget
                      return InkWell(
                        highlightColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          setState(() {
                            for (var element in dataModels) {
                              element.isSelected = false;
                            }
                            dataModels[index].isSelected = true;
                            goalAchieved = dataModels[index].dietNumber;
                          });
                        },
                        child: RadioItem(dataModels[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: SizedBox(
                width: 200,
                child: TextButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(FitnessAppTheme.nearlyBlue),
                      foregroundColor:
                          MaterialStateProperty.all(FitnessAppTheme.white)),
                  child: const Text(
                    'Continue',
                  ),
                  onPressed: () => [
                    widget.onComplete(goalAchieved),
                    Navigator.pushNamed(context, '/physical')
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RadioItem extends StatelessWidget {
  final UserModel _item;
  const RadioItem(this._item);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: _item.isSelected
            ? [FitnessAppTheme.selectorShadow]
            : [FitnessAppTheme.transperentShadow],
        color: _item.isSelected
            ? FitnessAppTheme.white
            : FitnessAppTheme.selectorGrayBackGround,
        border: Border.all(
            width: 1.0,
            color: _item.isSelected
                ? FitnessAppTheme.nearlyBlue
                : Colors.transparent),
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
      ),
      margin: const EdgeInsets.all(15).copyWith(top: 0.0),
      padding:
          const EdgeInsets.only(left: 20, right: 20, top: 7.5, bottom: 7.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                _item.title,
                style: _item.isSelected
                    ? FitnessAppTheme.selectorBigTextAction
                    : FitnessAppTheme.selectorBigText,
              ),
              Text(_item.subtitle, style: FitnessAppTheme.selectorMiniLabel)
            ],
          ),
          Padding(
            padding: EdgeInsets.only(right: _item.padding),
            child: Container(
              child: _item.isSelected
                  ? Image.asset(
                      "assets/selector/" + _item.icon + "Color.png",
                      height: 80,
                    )
                  : Image.asset(
                      "assets/selector/" + _item.icon + ".png",
                      height: 80,
                    ),
            ),
          )
        ],
      ),
    );
  }
}
