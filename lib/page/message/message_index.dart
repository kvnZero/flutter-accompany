import 'package:flutter/material.dart';
import 'package:accompany/widget/msgWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:accompany/common/message_fun.dart';

class MessageIndex extends StatefulWidget {
  @override
  _MessageIndexState createState() => _MessageIndexState();
}

class _MessageIndexState extends State<MessageIndex> with AutomaticKeepAliveClientMixin {
  Map packet;
  List msgList = [];
  bool zeroMsg = false;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('唠个嗑',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
        centerTitle: false,
        elevation: 0.5,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.person_add), onPressed: (){print("跳转添加好友");}),
        ],
      ),
      body: ListView(
        children: <Widget>[
          showList(),
        ],
      )
    );
  }
  Widget showList(){
    if(msgList.length==0){
      //数据为空 请求读取数据 返回转圈圈 考虑到一次性加载五页内容 则先加载本地数据然后顶部提醒加载
      if(zeroMsg){
        return Center(
            child: Padding(padding: EdgeInsets.only(top: 20),child: Text("消息列表空荡荡～"),)
        );
      }else{
        return Center(
            child: Padding(padding: EdgeInsets.only(top: 20),child: CircularProgressIndicator(),)
        );
      }
    }
    //有数据 直接展示数据
    List<MsgWidget> _list =[];
    msgList.forEach((value){
      _list.add(MsgWidget(message: value));
    });
    return Column(
      children: _list.map((e)=>e).toList(),
    );
  }

  void getList() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String _saveUser = _prefs.getString('user_data');
    Future<List> _list =  MessageFun?.getMessageList(json.decode(_saveUser)['id']);
    _list.then((value){
      setState(() {
        if(value.length==0){
          zeroMsg=true;
        }
        msgList = value;
      });
    });
//    Future<Response> response = Dio().post("http://192.168.1.5:8000/getmessagelist/",data: {'token':token});
  }
}