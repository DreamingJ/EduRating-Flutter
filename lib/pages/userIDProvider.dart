import 'package:flutter/Material.dart';

class UserIDProvider extends ChangeNotifier{
  String _userID = "2018211563";
  String get userID => _userID;

  void change(String value){
    _userID = value;
    notifyListeners();
  }
}