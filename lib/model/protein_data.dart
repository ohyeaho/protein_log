import 'package:flutter/material.dart';

class ProteinData {
  final String proteinName;
  final Color? color;
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
        'color': color.toString(),
        'proteinIntake': proteinIntake,
        'controller': controller.toString(),
      };

  ProteinData.fromJson(Map<String, dynamic> json)
      : proteinName = json['proteinName'],
        color = json['color'] as Color,
        proteinIntake = json['proteinIntake'],
        controller = json['controller'] as TextEditingController;
}
