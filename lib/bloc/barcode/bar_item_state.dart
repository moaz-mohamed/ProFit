import 'package:flutter/material.dart';
import 'package:profit/models/food_data_model.dart';

@immutable
abstract class BarCodeState {}

class BarCodeInitial extends BarCodeState {
  @override
  List<Object> get props => [];
}

class BarCodeLoading extends BarCodeState {
  @override
  List<Object> get props => [];
}

class BarCodeLoaded extends BarCodeState {
  final Items items;
  BarCodeLoaded(this.items);
  @override
  List<Object>? get props => null;
}

class BarCodeLoadedError extends BarCodeState {
  final String message;
  BarCodeLoadedError(this.message);
  @override
  List<Object>? get props => null;
}
