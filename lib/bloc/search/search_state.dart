import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:profit/models/food_data.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchLoading extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchLoaded extends SearchState {
  final Items recipes;
  SearchLoaded(this.recipes);
  @override
  List<Object> get props => [];
}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);
  @override
  List<Object> get props => [];
}
