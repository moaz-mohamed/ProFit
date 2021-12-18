import 'package:flutter/material.dart';
import 'package:profit/models/food_data.dart';

@immutable
abstract class FoodItemState {}

class FoodItemInitial extends FoodItemState {
  @override
  List<Object> get props => [];
}

class FoodItemLoading extends FoodItemState {
  @override
  List<Object> get props => [];
}

class FoodItemLoaded extends FoodItemState {
  final Items items;
  FoodItemLoaded(this.items);
  @override
  List<Object>? get props => null;
}

class FoodItemError extends FoodItemState {
  final String message;
  FoodItemError(this.message);
  @override
  List<Object>? get props => null;
}
