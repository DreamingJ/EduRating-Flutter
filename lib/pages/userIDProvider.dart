import 'package:flutter/Material.dart';

// class UserIDProvider extends ChangeNotifier{
  
//   String _userID = "2018211563";
//   String get userID => _userID;

//   void change(String value){
//     _userID = value;
//     notifyListeners();
//   }
// }

//其实不用provider用全局变量也能搞定，并不是实时的状态管理
class UserInfoProvider extends ChangeNotifier{
  //默认值
  String _userID="2018211563";
  String _userName = "明君";
  String _deptName = "计算机学院";
  String _status = "学生";
  // int _teachEvalNum = 0;

  String get userID => _userID;
  String get userName => _userName;
  String get deptName => _deptName;
  String get status => _status;
  // int get teachEvalNum=>_teachEvalNum;
  void change(String userID,String userName,String status, String deptName){
    _userID = userID;
    _userName = userName;
    _deptName = deptName;
    _status = status;
    notifyListeners();
  }



}