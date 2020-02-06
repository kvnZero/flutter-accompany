import 'dart:convert';

import 'package:accompany/common/user_fun.dart';
import 'package:accompany/data/classes/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthModel extends ChangeNotifier{
  User _user;

  Future<String> loadLogged() async {
    //如果是已经登陆的用户 获取存储在本地的token验证是否过期
    var _prefs = await SharedPreferences.getInstance();
    String _saveUser = _prefs.getString('user_data');
    if(_saveUser!=null){
      Map _newUser = await UserFun?.tokenLogin(json.decode(_saveUser)['usertoken']);
      if (_newUser['user'] != null) {
        _user = _newUser['user'];
        notifyListeners();
      }
      if (_newUser['user']?.usertoken == null || _newUser['user'].usertoken.isEmpty) return _newUser['msg'];
    }
    return '';
  }

  User get user => _user;

  Future<String> login({
    @required String username,
    @required String password,
  }) async {
    String _username = username;
    String _password = password;

    Map _newUser = await UserFun?.userLogin(_username,_password);
    if (_newUser['user'] != null) {
      _user = _newUser['user'];
      notifyListeners();
      SharedPreferences.getInstance().then((prefs) {
        var _save = json.encode(_user.toJson());
        prefs.setString("user_data", _save);
      });
    }

    if (_newUser['user']?.usertoken == null || _newUser['user'].usertoken.isEmpty) return _newUser['msg'];
    return '';
  }

  void logout() async{
    var _prefs = await SharedPreferences.getInstance();
    _prefs.remove('user_data');
    _user = null;
    notifyListeners();
  }
}