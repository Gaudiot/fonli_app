import 'package:flutter/material.dart';

class BaseViewState extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool _hasError = false;
  bool get hasError => _hasError;

  set hasError(bool value) {
    _hasError = value;
    notifyListeners();
  }

  @override
  void notifyListeners() => super.notifyListeners();
}
