import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:profit/services/auth.dart';
import 'package:profit/services/firestore_database.dart';
import 'package:profit/themes/ThemeUI.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:profit/widgets/IntroPage/Intro/login_screen.dart';
// import firestore

class Sucess extends StatefulWidget {
  @override
  State<Sucess> createState() => _SucessState();
}

class _SucessState extends State<Sucess> {
  AuthenticationService authServices = AuthenticationService();
  DatabaseService databaseService = DatabaseService();
  FirebaseAuth auth = FirebaseAuth.instance;
  String username = "";
  String userCalories = "";
  checkAuthentication() async {
    auth.authStateChanges().listen((User? user) {
      if (user == null) {
        // Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => true);
        // Navigator.pop(context);
        // Navigator.pushReplacementNamed(context, '/login');

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) {
        //       return LoginScreen();
        //     },
        //   ),
        // );
        //  Navigator.removeRoute(context, (Route<dynamic> route) => false)
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          ModalRoute.withName('/sucess'),
        );
        // Navigator.of(context).popUntil(ModalRoute.withName('/sucess'));

        //   Navigator.pushNamedAndRemoveUntil
        //Navigator.pushNamedAndRemoveUntil(context, '/login', ModalRoute.withName('/success'));

//Navigator.of(context).pushNamedAndRemoveUntil('/login', ModalRoute.withName('/success'));
//Navigator.push(context,  MaterialPageRoute(builder: (context) => LoginScreen()));

      }
    });
  }

  // checkAuthenticationGoogle() async {
  //   User? googleUser = await auth.currentUser;

  //   // user = userCredential.user;
  //   if (googleUser == null) {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) {
  //           return const LoginScreen();
  //         },
  //       ),
  //     );
  //   }
  // }
  @override
  void initState() {
    // TODO: implement initState
    
    super.initState();
    getName();
    getCalories();

  }

  void signout() async {
    await authServices.signOutGoogle();
    await authServices.signOut();
    await checkAuthentication();
  }


  getName() async {
    String? name;
    //  final FirebaseFirestore db = FirebaseFirestore.instance;
    //   final CollectionReference users =
    //      FirebaseFirestore.instance.collection('users');
    String userId = auth.currentUser!.uid;
    print(userId);
    DocumentReference doc =
        FirebaseFirestore.instance.collection("users").doc(userId);

    await doc.get().then((value) {
      name = value.get('name').toString();
    });

    // username = name!.toString();
    setState(() => username = name!);
  }
  getCalories() async {
    double? calories;
    //  final FirebaseFirestore db = FirebaseFirestore.instance;
    //   final CollectionReference users =
    //      FirebaseFirestore.instance.collection('users');
    String userId = auth.currentUser!.uid;

    DocumentReference doc =
        FirebaseFirestore.instance.collection("users").doc(userId);
     
   doc.snapshots().listen((snapshot) { 
    calories =  snapshot.get('remainingCalories');
        
    setState(() {
       
       userCalories = calories!.toStringAsFixed(2);
    });
    });

    // await doc.get().then((value) {
    //   calories = value.get('calories');
    // });

  }




  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: FitnessAppTheme.selectorGrayBackGround,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: FitnessAppTheme.selectorGrayBackGround,
          iconTheme: IconThemeData(color: Colors.black),
          title: const Text('Signed in',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          elevation: 0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              
              Text('Welcome ' + username , style: const TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontFamily: 'Bebas',
                  fontWeight: FontWeight.bold,
                ),),
              const SizedBox(height: 50),
              Container(
                width: 110,
                height:110,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Image.asset(
                  'assets/calories/flame.png',
                  width: 100,
                  height: 100,
                  //  color: Colo,
                ),
              ),
           
               Text('Your Remaining Calories for Today'  ,style:  TextStyle(
                  color: Colors.red.shade800,
                  fontSize: 20,
                  fontFamily: 'Bebas',
                  fontWeight: FontWeight.bold,
                ),),
              //  Text('Welcome ' + users.doc(auth.currentUser!.uid).toString()),
               Text(userCalories  ,style:  TextStyle(
                  color: Colors.red.shade800,
                  fontSize: 50,
                  fontFamily: 'Bebas',
                  fontWeight: FontWeight.bold,
                ),),
                const SizedBox(height: 30,),
                  //make a button with on click function
                  ElevatedButton(
                    onPressed: () {
                      databaseService.AddDinnerToFirestoreUser(
                          id: auth.currentUser!.uid,
                          name: "lunch23",
                          calories: 2.1,
                          quantity: 3.2,
                          protein: 777.7,
                          fat: 5.5,
                          carbs: 6.2);
                    },
                    child: Text('Add Meals to Current User'),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      databaseService.AddWorkoutToFirestoreUser(
                          id: auth.currentUser!.uid,
                          name: "Cycling",
                          burnedCalories: 350,
                          duration: 30);
                    },
                    child: Text('Add Workout to Current User'),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                      child: const Text('Signout'),
                      onPressed: signout,
                      style: ElevatedButton.styleFrom(
                        primary: FitnessAppTheme.nearlyBlue,
                        elevation: 20,
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        textStyle: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        fixedSize: const Size(130, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                      )),
                  const SizedBox(height: 40),
                  // ElevatedButton(
                  //     child: const Text('Signout google'),
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
          ),
        );
  }
}
