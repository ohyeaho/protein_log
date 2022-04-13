import 'package:flutter/material.dart';

class ProteinData {
  final String proteinName;
  final Color? color;
  int? proteinIntake;
  TextEditingController? controller;

  ProteinData({this.proteinName = '', this.color, this.proteinIntake, this.controller});
}
