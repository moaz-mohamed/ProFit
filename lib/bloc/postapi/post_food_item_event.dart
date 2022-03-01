import 'package:flutter/material.dart';

@immutable
abstract class FoodItemEvent {}

class calculateItemsEvent extends FoodItemEvent {
  num quantity;

  String foodId;
  calculateItemsEvent({
    required this.quantity,
    required this.foodId,
  });
}
