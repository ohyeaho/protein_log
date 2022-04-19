import 'package:flutter/material.dart';

class ProteinData {
  String proteinName;
  Color? color;
  int proteinIntake;
  TextEditingController? controller;

  ProteinData({
    this.proteinName = '',
    this.color,
    this.proteinIntake = 0,
    this.controller,
  });

  Map toJson() => {
        'proteinName': proteinName,
        'color': color,
        'proteinIntake': proteinIntake,
        'controller': controller.toString(),
      };

  ProteinData.fromJson(Map json)
      : proteinName = json['proteinName'],
        color = json['color'],
        proteinIntake = json['proteinIntake'],
        controller = json['controller'];
}
