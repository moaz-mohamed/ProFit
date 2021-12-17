import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class FoodItemEvent extends Equatable {}

class FetchItems extends FoodItemEvent {
  String food;
  List<Object> get props => [];
  FetchItems({required this.food});
}

class SearchItems extends FoodItemEvent {
  List<Object> get props => [];
}
