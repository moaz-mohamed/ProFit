import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:profit/services/auth.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';

class StepsScreen extends StatefulWidget {
  @override
  StepsScreenState createState() => StepsScreenState();
}

class StepsScreenState extends State<StepsScreen> {
  Stream<StepCount>? _stepCountStream;
  FirebaseAuth auth = FirebaseAuth.instance;

  AuthenticationService authServices = AuthenticationService();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  // StepCount? event;
  // Stream<PedestrianStatus>? _pedestrianStatusStream;

  late String _todaySteps = '0', _totalSteps, _savedSteps;
  //  String ?
  //     _savedSteps;

  int? lastDay = 0;

  late int _currentDay;
//   checkAuthentication() async {
//     auth.authStateChanges().listen((User? user) {
//       if (user == null) {
//         // Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => true);
//         // Navigator.pop(context);
//         // Navigator.pushReplacementNamed(context, '/login');

//         // Navigator.push(
//         //   context,
//         //   MaterialPageRoute(
//         //     builder: (context) {
//         //       return LoginScreen();
//         //     },
//         //   ),
//         // );
//         //  Navigator.removeRoute(context, (Route<dynamic> route) => false)
//         Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (context) => LoginScreen()),
//           ModalRoute.withName('/steps'),
//         );
//         // Navigator.of(context).popUntil(ModalRoute.withName('/sucess'));

//         //   Navigator.pushNamedAndRemoveUntil
//         //Navigator.pushNamedAndRemoveUntil(context, '/login', ModalRoute.withName('/success'));

// //Navigator.of(context).pushNamedAndRemoveUntil('/login', ModalRoute.withName('/success'));
// //Navigator.push(context,  MaterialPageRoute(builder: (context) => LoginScreen()));

//       }
//     });
//   }

  // void signout() async {
  //   await authServices.signOutGoogle();
  //   await authServices.signOut();
  // //  await checkAuthentication();
  // }
  //    await users.doc(auth.currentUser!.uid).get().then((value) {
  //      print(value.data());
  //  });
// DocumentSnapshot userDocument =
  //String name = await users.doc(auth.currentUser!.uid).get().then((value) => null)
  //return name;
//    if (userDocument.exists) {
//      print("fuckkkkkkkk");
// Map<String, dynamic>? data = userDocument.data() as Map<String, dynamic>?;
// String name = data!['name'];
//  print(name);
//    }
/*
    String? name = await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
       .get()
        .then((value) {
      return value.data()!['name']; // Access your after your get the data
    });
    print(name); */
  // }
  loadData() async {
    final SharedPreferences prefs = await _prefs;
    _currentDay = prefs.getInt('currentDay') ?? DateTime.now().hour;

    _todaySteps = prefs.getString('todaySteps') ?? '0';
    print("today steps from shared preferences : " + _todaySteps);
    print("current day from shared preferences : " + _currentDay.toString());
  }

  @override
  initState() {
    // _todaySteps = _prefs.then((SharedPreferences prefs) {
    //   return prefs.getString('todaySteps') ?? '0';
    // });
    loadData();
    initPlatformState();
    print("inside initstateeeeeeeeeeeee");
    super.initState();
    // getName();
    // getCalories();
    //getSteps();

    // getSteps();
    // _savedSteps = _totalSteps;
    // prefs.setString('savedSteps', _savedSteps!);

    // day = 0;
    // currentdate= DateTime.now().minute;
    // _savedSteps = _totalSteps;
  }

  @override
  void dispose() {
    _prefs.then((SharedPreferences prefs) {
      prefs.setString('todaySteps', _todaySteps);
      prefs.setInt('currentDay', _currentDay);
    });
    print("inside disposeeeeeeeeeeeeeeeee");
    super.dispose();
  }

  Future<void> onStepCount(StepCount event) async {
    final SharedPreferences prefs = await _prefs;
    _savedSteps = prefs.getString('savedSteps') ?? event.steps.toString();
    prefs.setString('savedSteps', _savedSteps);
    //Todo
    // _savedSteps = prefs.getString('savedSteps') ?? event.steps.toString();

    print(event);

    _currentDay = DateTime.now().hour;
    lastDay = prefs.getInt('lastDay') ?? _currentDay;
    prefs.setInt('lastDay', lastDay!);
    if (_currentDay != lastDay) {
      print("New dayyyyyyyyy");
      lastDay = _currentDay;
      _savedSteps = event.steps.toString();
      _todaySteps = '0';
      prefs.setInt('lastDay', lastDay!);
      prefs.setString('savedSteps', _savedSteps);
      prefs.setString('todaySteps', _todaySteps);
    }

    setState(() {
      _todaySteps = (event.steps - int.parse(_savedSteps)).toString();
      print(_savedSteps);
    });
    // prefs.setString('todaySteps', _todaySteps);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _todaySteps = 'Step Count not available';
    });
  }

  void initPlatformState() async {
    if (await Permission.activityRecognition.request().isGranted) {
      print("requesteddddddd");

      _stepCountStream = Pedometer.stepCountStream;

      _stepCountStream!.listen(onStepCount).onError(onStepCountError);

      // Either the permission was already granted before or the user just granted it.

    }

    if (!mounted) return;
  }

  // getName() async {
  //   String? name;
  //   //  final FirebaseFirestore db = FirebaseFirestore.instance;
  //   //   final CollectionReference users =
  //   //      FirebaseFirestore.instance.collection('users');
  //   String userId = auth.currentUser!.uid;
  //   print(userId);
  //   DocumentReference doc =
  //       FirebaseFirestore.instance.collection("users").doc(userId);

  //   await doc.get().then((value) {
  //     name = value.get('name').toString();
  //   });
  //   print(name);
  //   // username = name!.toString();
  //   setState(() => username = name!);
  // }
  // getCalories() async {
  //   double? calories;
  //   //  final FirebaseFirestore db = FirebaseFirestore.instance;
  //   //   final CollectionReference users =
  //   //      FirebaseFirestore.instance.collection('users');
  //   String userId = auth.currentUser!.uid;

  //   DocumentReference doc =
  //       FirebaseFirestore.instance.collection("users").doc(userId);

  //   await doc.get().then((value) {
  //     calories = value.get('calories');
  //   });
  //   print(calories);
  //   setState(() => userCalories = calories!.toString());
  // }

  // Future<String?> getSteps()  async {
  //   late Future<String?> steps;
  //   SharedPreferences prefs = await _prefs;

  //   // _totalSteps = event!.steps.toString();
  // steps = _prefs.then((SharedPreferences prefs) {
  //     return prefs.getString('savedSteps') ?? '0';
  //   });

  //   setState(() => _savedSteps =  steps as String );
  // }

  @override
  Widget build(BuildContext context) {
    print("inside build");
    // print(getName());
    // getState();
    // print(s);
    return WillPopScope(
      onWillPop: () async {
        print("inside pop scopeeeeeeeeeeee");
        _prefs.then((SharedPreferences prefs) {
          prefs.setString('todaySteps', _todaySteps);
          prefs.setInt('currentDay', _currentDay);
        });
        // You can do some work here.
        // Returning true allows the pop to happen, returning false prevents it.
        return true;
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //  Text('Welcome ' + users.doc(auth.currentUser!.uid).toString()),

            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.width * 0.3,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
              ),
              child: Image.asset(
                'assets/steps/shoe.png',
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.width * 0.3,
                //  color: Colo,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Text(
              'Today\'s Steps',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 30,
                fontFamily: 'SourceSansPro',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Text(
              _todaySteps,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 50,
                fontFamily: 'Bebas',
                fontWeight: FontWeight.bold,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 15),
            ),
            const SizedBox(height: 40),
            // ElevatedButton(
            //     child: const Text('Signout'),
            //     onPressed: signout,
            //     style: ElevatedButton.styleFrom(
            //       primary: FitnessAppTheme.nearlyBlue,
            //       elevation: 20,
            //       padding: const EdgeInsets.symmetric(horizontal: 30),
            //       textStyle: const TextStyle(
            //           fontSize: 20, fontWeight: FontWeight.bold),
            //       fixedSize: const Size(130, 50),
            //       shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(50)),
            //     )),
          ],
        ),
      ),
    );
  }
}

/*
 children: <Widget>[
                  const SizedBox(
                    height: 50,
                    width: 15,
                  ),
                  //  Text('Welcome ' + users.doc(auth.currentUser!.uid).toString()),
                  Center(
                    child: Container(
                      width: 90,
                      height: 90,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Image.asset(
                        'assets/steps/shoe.png',
                        width: 90,
                        height: 90,
                        //  color: Colo,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  Text(
                    'steps',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20,
                      fontFamily: 'Bebas',
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    _todaySteps!,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 50,
                      fontFamily: 'Bebas',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 15),
                  ),
                ],
                */