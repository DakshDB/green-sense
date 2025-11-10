import 'package:flutter/foundation.dart';
import 'package:green_sense/models/calculator_input.dart';
import 'package:green_sense/models/calculator_result.dart';
import 'package:green_sense/services/calculator_service.dart';

class CalculatorProvider extends ChangeNotifier {
  final CalculatorService _service = CalculatorService();
  CalculatorInput _input = CalculatorInput.empty();
  CalculatorResult? _result;
  bool _isLoading = false;

  CalculatorInput get input => _input;
  CalculatorResult? get result => _result;
  bool get isLoading => _isLoading;

  void updateInput(CalculatorInput input) {
    _input = input;
    notifyListeners();
  }

  Future<void> calculate() async {
    _isLoading = true;
    notifyListeners();

    try {
      _result = _service.calculate(_input);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void reset() {
    _input = CalculatorInput.empty();
    _result = null;
    notifyListeners();
  }
}
