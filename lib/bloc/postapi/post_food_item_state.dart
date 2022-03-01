import 'package:flutter/material.dart';
import 'package:profit/models/post_food_data_model.dart';

@immutable
abstract class FoodItemState {}

class FoodItemInitial extends FoodItemState {}

class FoodItemLoading extends FoodItemState {}

class FoodItemLoaded extends FoodItemState {
  final CalculatedItems items;
  FoodItemLoaded(this.items);
}

class FoodItemError extends FoodItemState {
  final String message;
  FoodItemError(this.message);
}
