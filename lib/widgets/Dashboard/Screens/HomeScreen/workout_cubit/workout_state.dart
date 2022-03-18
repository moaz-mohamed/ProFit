part of 'workout_cubit.dart';

@immutable
abstract class WorkoutState {}

class WorkoutInitial extends WorkoutState {}

class WorkoutCalculationState extends WorkoutState {
  WorkoutCalculationState(
      {required this.workout, required this.workoutCalculation});
  final String workout;
  final String workoutCalculation;

  get calculatedWorkout => workoutCalculation;
  get workoutName => workout;
}

class WorkoutError extends WorkoutState {}
