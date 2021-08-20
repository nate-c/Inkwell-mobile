import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:inkwell_mobile/models/investmentObject.dart';

class UserProvider with ChangeNotifier {
  String _username = '';
  String get username => _username;
  List<InvestmentObject> _investments = [];
  List<InvestmentObject> get investments => _investments;
  int _accountBalance = 0;
  int get accountBalance => _accountBalance;
  int _accountId = 0;
  int get accountId => _accountId;
  int _userId = 0;
  int get userId => _userId;

  UserProvider() {}

  void setUsername(String username) {
    _username = username;
    notifyListeners();
  }

  void setInvestments(List<InvestmentObject> investments) {
    _investments = investments;
    notifyListeners();
  }

  void setAccountBalance(int accountBalance) {
    _accountBalance = accountBalance;
    notifyListeners();
  }

  void setAccountId(int accountId) {
    _accountId = accountId;
    notifyListeners();
  }

  void setUserId(int userId) {
    _userId = userId;
    notifyListeners();
  }
}
