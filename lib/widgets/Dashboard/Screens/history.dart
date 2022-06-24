import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:profit/services/firestore_database.dart';
import 'package:profit/themes/theme_ui.dart';

class MyHistory extends StatefulWidget {
  @override
  _MyHistoryState createState() => _MyHistoryState();
}

class _MyHistoryState extends State<MyHistory> {
  DatabaseService dbService = DatabaseService();
  FirebaseAuth auth = FirebaseAuth.instance;
  String? userId;
  String? foodName;
  double? calories;
  double? quantity;

  @override
  void initState() {
    userId = auth.currentUser!.uid;
    // var future = getHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My History"),
      ),
      body: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, int index) {
            return Container(
              constraints: const BoxConstraints(
                maxHeight: double.infinity,
              ),
              margin: const EdgeInsets.all(30),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: FitnessAppTheme.white,
                boxShadow: [
                  BoxShadow(
                    color: FitnessAppTheme.nearlyBlack.withOpacity(0.12),
                    blurRadius: 5.0,
                    spreadRadius: 1.1,
                  ),
                ],
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('users')
                            .doc(userId)
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var data = snapshot.data as DocumentSnapshot;
                            var historyList = data['history'];
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: historyList.length,
                              itemBuilder: (context, curr) {
                                return Column(children: [
                                  Card(
                                    margin: const EdgeInsets.all(3),
                                    elevation: 1,
                                    shape: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: FitnessAppTheme.nearlyWhite,
                                            width: 1)),
                                    child: ListTile(
                                      title: Row(
                                        children: [
                                          Text(historyList[curr]['name']
                                              .toString()),
                                        ],
                                      ),
                                      subtitle: Text(historyList[curr]
                                                  ['calories']
                                              .toString() +
                                          " kCal"),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(DateTime
                                                  .fromMicrosecondsSinceEpoch(
                                                      historyList[curr]['date']
                                                          .microsecondsSinceEpoch)
                                              .toString())
                                        ],
                                      ),
                                    ),
                                  )
                                ]);
                              },
                            );
                          } else {
                            return const Text(" ");
                          }
                        }),
                  ]),
            );
          }),
    );
  }
}
