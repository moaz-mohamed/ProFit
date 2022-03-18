// ignore_for_file: invalid_required_positional_param

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'workout_state.dart';

class WorkoutCubit extends Cubit<WorkoutState> {
  WorkoutCubit() : super(WorkoutInitial());
  void addWorkout(@required String type, @required String duration) {
    switch (type) {
      case 'Walking':
        emit(WorkoutCalculationState(
            workout: type,
            workoutCalculation: (int.parse(duration) * 4.7).toString()));

        break;

      case 'Bicycling':
        emit(WorkoutCalculationState(
            workout: type,
            workoutCalculation: (int.parse(duration) * 6.7).toString()));

        break;

      case 'Jogging':
        emit(WorkoutCalculationState(
            workout: type,
            workoutCalculation: (int.parse(duration) * 7.9).toString()));

        break;
      default:
    }
  }

  @override
  void onChange(Change<WorkoutState> change) {
    // TODO: implement onChange
    super.onChange(change);
    print(change);
  }
}
