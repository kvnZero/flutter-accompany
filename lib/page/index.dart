import 'package:flutter/material.dart';
import 'home/home_index.dart';
import 'group/group_index.dart';
import 'package:toast/toast.dart';
import 'message/message_index.dart';
import 'package:accompany/common/message_fun.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:dio/dio.dart';

class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  int _currentIndex = 0;
  var _controller = PageController(initialPage: 0);
  DateTime _lastPressedAt;

  List<Widget> pageView = [
    HomeIndex(),
    GroupIndex(),
    MessageIndex(),
    HomeIndex(),
  ];

  List navItem = [
    {'icon':Icons.home,'title':'首页'},
    {'icon':Icons.local_pizza,'title':'饲主圈'},
    {'icon':Icons.message,'title':'消息'},
    {'icon':Icons.person,'title':'我'},
  ];

  void getNewMessage() async{
    String token;
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String _saveUser = _prefs.getString('user_data');
    token = json.decode(_saveUser)['usertoken'];
    await MessageFun?.getMessage(token,myid: json.decode(_saveUser)['id']);
//    Future<Response> response = Dio().post("http://192.168.1.5:8000/getmessagelist/",data: {'token':token});
//    MessageFun?.getMessage(userToken)
  }

  @override
  void initState() {
    // TODO: implement initState

    getNewMessage();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(child: Scaffold(
      body: PageView(
        controller: _controller,
        children: pageView,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: navItem.map((e)=>BottomNavigationBarItem(icon: Icon(e['icon']),title: Text(e['title']))).toList(),
        currentIndex: _currentIndex,
        onTap: (int index){
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue[400],
        unselectedItemColor: Colors.black26,
      ),
    ), onWillPop: ()async{
      if (_lastPressedAt == null ||
          DateTime.now().difference(_lastPressedAt) > Duration(seconds: 1)) {
        //两次点击间隔超过1秒则重新计时
        _lastPressedAt = DateTime.now();
        Toast.show("再次点击返回退出程序", context);
        return false;
      }
      return true;
    });
  }
}
