import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class BarCodeEvent extends Equatable {}

class FetchBarCodeItem extends BarCodeEvent {
  String barcode;
  List<Object> get props => [];
  FetchBarCodeItem({required this.barcode});
}
