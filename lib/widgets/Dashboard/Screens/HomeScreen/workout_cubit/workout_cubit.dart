import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'workout_state.dart';

class WorkoutCubit extends Cubit<WorkoutState> {
  FirebaseAuth auth = FirebaseAuth.instance;

  String weight = "";
  getData() async {
    String userId = auth.currentUser!.uid;
    DocumentReference doc =
        FirebaseFirestore.instance.collection("users").doc(userId);

    await doc.get().then((value) {
      weight = value.get('weight');
    });
  }

  WorkoutCubit() : super(WorkoutInitial());
  void addWorkout(@required String type, @required String duration) async {
    double walkingMet = 3.025;
    double runningMet = 11;
    double bicyclingMet = 4.16;
    double swimmingMet = 5.75;
    double joggingMet = 7;
    await getData();
    switch (type) {
      case 'Walking':
        emit(WorkoutCalculationState(
            workout: type,
            workoutCalculation: (int.parse(duration) *
                    walkingMet *
                    3.5 *
                    ((int.parse(weight)) / 200))
                .toString()));

        break;

      case 'Bicycling':
        emit(WorkoutCalculationState(
            workout: type,
            workoutCalculation: (int.parse(duration) *
                    bicyclingMet *
                    3.5 *
                    ((int.parse(weight)) / 200))
                .toString()));

        break;

      case 'Jogging':
        emit(WorkoutCalculationState(
            workout: type,
            workoutCalculation: (int.parse(duration) *
                    joggingMet *
                    3.5 *
                    ((int.parse(weight)) / 200))
                .toString()));

        break;

      case 'Running':
        emit(WorkoutCalculationState(
            workout: type,
            workoutCalculation: (int.parse(duration) *
                    runningMet *
                    3.5 *
                    ((int.parse(weight)) / 200))
                .toString()));

        break;
      case 'Swimming':
        print(weight);
        emit(WorkoutCalculationState(
            workout: type,
            workoutCalculation: (int.parse(duration) *
                    swimmingMet *
                    3.5 *
                    ((int.parse(weight)) / 200))
                .toString()));

        break;

      default:
    }
  }

  @override
  void onChange(Change<WorkoutState> change) {
    super.onChange(change);
    print(change);
  }
}
