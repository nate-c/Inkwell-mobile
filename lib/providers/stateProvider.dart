import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StateProvider with ChangeNotifier {
  String _selectedCompanyTicker = '';
  String get selectedCompanyTicker => _selectedCompanyTicker;
  StateProvider() {}

  void setSelectedCompany(String ticker) {
    _selectedCompanyTicker = ticker;
    notifyListeners();
  }
}
