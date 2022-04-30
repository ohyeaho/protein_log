class ProteinFormula {
  final int? weight;
  final int? motion;
  final int? ageId;

  ProteinFormula({this.weight, this.motion, this.ageId});

  double? minResult;
  double? maxResult;
  String? _result;

  String? resultProtein() {
    if (motion == 0) {
      _result = ageId == 2 ? (weight! * 0.8).toStringAsFixed(1) : (weight! * 0.8 * 1.1).toStringAsFixed(1);
    } else if (motion == 1) {
      minResult = ageId == 2 ? weight! * 0.8 : weight! * 0.8 * 1.1;
      maxResult = ageId == 2 ? weight! * 1.1 : weight! * 1.1 * 1.1;
      _result = '${minResult!.toStringAsFixed(1)}~${maxResult!.toStringAsFixed(1)}';
    } else if (motion == 2) {
      minResult = ageId == 2 ? weight! * 1.2 : weight! * 1.2 * 1.1;
      maxResult = ageId == 2 ? weight! * 1.4 : weight! * 1.4 * 1.1;
      _result = '${minResult!.toStringAsFixed(1)}~${maxResult!.toStringAsFixed(1)}';
    } else if (motion == 3) {
      minResult = ageId == 2 ? weight! * 1.6 : weight! * 1.6 * 1.1;
      maxResult = ageId == 2 ? weight! * 1.7 : weight! * 1.7 * 1.1;
      _result = '${minResult!.toStringAsFixed(1)}~${maxResult!.toStringAsFixed(1)}';
    } else if (motion == 4) {
      minResult = ageId == 2 ? weight! * 1.2 : weight! * 1.2 * 1.1;
      maxResult = ageId == 2 ? weight! * 1.4 : weight! * 1.4 * 1.1;
      _result = '${minResult!.toStringAsFixed(1)}~${maxResult!.toStringAsFixed(1)}';
    } else if (motion == 5) {
      minResult = ageId == 2 ? weight! * 1.2 : weight! * 1.2 * 1.1;
      maxResult = ageId == 2 ? weight! * 1.7 : weight! * 1.7 * 1.1;
      _result = '${minResult!.toStringAsFixed(1)}~${maxResult!.toStringAsFixed(1)}';
    } else if (motion == 6) {
      minResult = ageId == 2 ? weight! * 1.5 : weight! * 1.5 * 1.1;
      maxResult = ageId == 2 ? weight! * 1.7 : weight! * 1.7 * 1.1;
      _result = '${minResult!.toStringAsFixed(1)}~${maxResult!.toStringAsFixed(1)}';
    } else if (motion == 7) {
      minResult = ageId == 2 ? weight! * 1.0 : weight! * 1.0 * 1.1;
      maxResult = ageId == 2 ? weight! * 1.2 : weight! * 1.2 * 1.1;
      _result = '${minResult!.toStringAsFixed(1)}~${maxResult!.toStringAsFixed(1)}';
    } else if (motion == 8) {
      minResult = ageId == 2 ? weight! * 1.4 : weight! * 1.4 * 1.1;
      maxResult = ageId == 2 ? weight! * 1.7 : weight! * 1.7 * 1.1;
      _result = '${minResult!.toStringAsFixed(1)}~${maxResult!.toStringAsFixed(1)}';
    } else if (motion == 9) {
      minResult = ageId == 2 ? weight! * 1.4 : weight! * 1.4 * 1.1;
      maxResult = ageId == 2 ? weight! * 1.8 : weight! * 1.8 * 1.1;
      _result = '${minResult!.toStringAsFixed(1)}~${maxResult!.toStringAsFixed(1)}';
    } else {
      return '';
    }
    return _result;
  }
}
