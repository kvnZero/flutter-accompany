import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:accompany/widget/msgWidget.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
class MessageIndex extends StatefulWidget {
  @override
  _MessageIndexState createState() => _MessageIndexState();
}

class _MessageIndexState extends State<MessageIndex> with AutomaticKeepAliveClientMixin {
  TextEditingController _controller = new TextEditingController();
//  IO.Socket socket;
  Map packet;
  List msgList = [];

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    //创建websocket连接
//    socket = IO.io('ws://127.0.0.1:8001?userid=1');
//    socket.on('connect', (_) {
//      print(socket.id);
//    });
//    socket.on('event', (data) => print(data));
//    socket.on('disconnect', (_) => print('disconnect'));
//    socket.on('fromServer', (data) => print(data));
//    socket.on('message', (data) => print(data));
    getList();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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

//  new Padding(
//  padding: const EdgeInsets.all(20.0),
//  child: FlatButton(onPressed: (){
//  print("1");
////          socket.send([{'msg':'hello','toid':100}]);
//  }, child: Text("1"))
//  ),

  Widget showList(){
    if(msgList.length==0){
      //数据为空 请求读取数据 返回转圈圈 考虑到一次性加载五页内容 则先加载本地数据然后顶部提醒加载
      return Center(
          child: Padding(padding: EdgeInsets.only(top: 20),child: CircularProgressIndicator(),)
      );
    }
    //有数据 直接展示数据
    List<MsgWidget> _list =[];
    msgList.forEach((value){
      _list.add(MsgWidget(message: value,));
    });
    return Column(
      children: _list.map((e)=>e).toList(),
    );
  }

  void getList() async{
    String token;
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String _saveUser = _prefs.getString('user_data');
    token = json.decode(_saveUser)['usertoken'];
    Future<Response> response = Dio().post("http://192.168.1.5:8000/getmessagelist/",data: {'token':token});
    response.then((value){
      setState(() {
        msgList = value.data;
      });
    });
  }

}