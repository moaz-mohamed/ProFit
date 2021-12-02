// import 'package:calory_calc/blocs/auth/bloc.dart';
// import 'package:calory_calc/providers/local_providers/userProvider.dart';

// import 'package:calory_calc/models/dbModels.dart';
// import 'package:calory_calc/utils/dataLoader.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import 'widgets/forms/forms.dart';

// ignore_for_file: unused_label

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:profit/widgets/intro_main.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
} 


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      // Call the splash screen first
      // Which calls next the intro page
      home: SplashScreen(),
    );
  }
}

//--->>> Splash screen
