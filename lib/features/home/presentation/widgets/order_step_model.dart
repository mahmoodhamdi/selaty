import 'package:flutter/material.dart';

class OrderStepModel {
  final String text;
  final IconData icon;
  DateTime? date;

  OrderStepModel({required this.text, required this.icon, this.date});
}
