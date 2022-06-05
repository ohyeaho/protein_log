import 'dart:math';

class BmiFormula {
  final int? height;
  final int? weight;

  BmiFormula({this.height, this.weight});

  double? _bmi;
  double? _standardWeight;
  double? _lowWeight;
  double? _highWeight;

  String? resultBmi() {
    _bmi = weight! / pow(height! / 100, 2);
    return _bmi!.toStringAsFixed(1);
  }

  String? resultStandardWeight() {
    _standardWeight = 22.0 * pow(height! / 100, 2);
    return _standardWeight!.toStringAsFixed(1);
  }

  String? resultLowWeight() {
    _lowWeight = 18.5 * pow(height! / 100, 2);
    return _lowWeight!.toStringAsFixed(1);
  }

  String? resultHighWeight() {
    _highWeight = 25.0 * pow(height! / 100, 2) + 0.01;
    return _highWeight!.toStringAsFixed(1);
  }
}
