import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StateProvider with ChangeNotifier {
  String _selectedCompanyTicker = '';
  String get selectedCompanyTicker => _selectedCompanyTicker;
  StateProvider() {}

  void setSelectedCompany(String ticker) {
    _selectedCompanyTicker = ticker;
    notifyListeners();
  }
}
