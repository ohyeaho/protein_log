import 'package:flutter/material.dart';

class ProteinData {
  final String proteinName;
  var color;
  int proteinIntake;
  TextEditingController? controller;

  ProteinData({
    this.proteinName = '',
    this.color,
    this.proteinIntake = 0,
    this.controller,
  });

  Map<String, dynamic> toJson() => {
        'proteinName': proteinName,
        'color': color,
        'proteinIntake': proteinIntake,
      };

  ProteinData.fromJson(Map<String, dynamic> json)
      : proteinName = json['proteinName'],
        color = json['color'],
        proteinIntake = json['proteinIntake'];
}
