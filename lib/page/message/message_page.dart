import 'dart:math';

import 'package:accompany/data/models/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:accompany/common/message_fun.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class MessagePage extends StatefulWidget {
  const MessagePage({
    @required this.toId,
    @required this.user,
    @required this.myId,
  });

  final int toId;
  final Map user;
  final int myId;
  @override
  _MessagePageState createState() => _MessagePageState(toId: toId,user: user, myId:myId);
}

class _MessagePageState extends State<MessagePage> {
  _MessagePageState({
    @required this.toId,
    @required this.user,
    @required this.myId,
  });
  int toId;
  int myId;
  Map user;
  IO.Socket socket;

  TextEditingController _textController = new TextEditingController();
  ScrollController _controller = ScrollController();
  GlobalKey _formKey = new GlobalKey<FormState>();
  List<Map> msgList = [];

  @override
  void initState() {
    // TODO: implement initState
    Future<List> _list =  MessageFun?.getWithMessageList(toId);
    _list.then((e){
      e.forEach((e){
        setState(() {
          msgList.add({'content':e['content'],'sender':e['uid']!=toId});
        });
      });
    });
    setState(() {
      socket = IO.io('ws://127.0.0.1:8001?userid=18');
    });
    socket.on('message', (data){
      print("收到消息啦");
      setState(() {
        msgList.add({'content':data['msg'],'sender':false});
      });
      MessageFun?.insertMessage({'id':data['mid'],'fromid':data['fromid'],'toid':data['toid'],'content':data['msg'],'read':1,'createTime':data['time']});
      //写入本地数据库
    });
    super.initState();
  }
  
  
  @override
  Widget build(BuildContext context) {

  jumpdown();

  return new Scaffold(
      appBar: new AppBar(
        title: Text(
          user['nickname'].toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
        centerTitle: true,
        elevation: 0.5,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.more_horiz), onPressed: () {
            print("跳转查看个人资料");
          }),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: msgList.map((e)=>messageWidget(e['content'], avaterurl:user['avater'],sender: e['sender'])).toList(),
              padding: EdgeInsets.only(top: 5,bottom: 5),
              controller: _controller,
              ),
          ),
          Theme(
            data: new ThemeData(primaryColor: Colors.blue),
            child: Container(
              color: Colors.grey[200],
            child: Form(
              key: _formKey,
              autovalidate: false,
              child: Row(
                children: <Widget>[
                  IconButton(icon: Icon(Icons.panorama), onPressed: (){print("选择图片");}),
                  Container(
                    height: 35,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 1.31,
                    color: Colors.white,
                    child: TextFormField(
                      onTap: (){jumpdown(jump: true);},
                      controller: _textController,
                      cursorColor: Colors.blue,
                      decoration: InputDecoration(
                        hintText: "输入内容",
                        contentPadding: EdgeInsets.only(left: 15, right: 15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius
                              .circular(5)),
                        ),
                      ),
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  IconButton(icon: Icon(Icons.send), onPressed: (){
                    if(_textController.text.trim().length==0){
                      return;
                    }
                    String _text = _textController.text.trim();
                    _textController.clear();
                    setState(() {
                      msgList.add({'content':_text,'avaterurl':'','sender':true});
                    });
                    jumpdown(jump: true,time: 100);
                    Future<Map> _mp = MessageFun?.sendMessage(myId.toString(), toId.toString(), _text);
                    _mp.then((e){
                      socket.send([{'msg':e['content'],'fromid':e['fromid'],'mid':e['id'],'toid':e['toid'],'time':e['create_time']}]);
                    });
                  }),
                ]
              )
            ),
          ))
        ],
      ),
    );
  }

  void jumpdown({bool jump = false,int time:500}) async{
    if (jump) {
      var duration = new Duration(milliseconds: time);
      new Future.delayed(duration, (){
        _controller.jumpTo(_controller.position.maxScrollExtent);
      });
    }
    if(_controller.positions.isNotEmpty){
      _controller.jumpTo(_controller.position.maxScrollExtent);
    }else{
      var duration = new Duration(milliseconds: 500);
      new Future.delayed(duration, (){
        jumpdown();
      });
    }
  }

  Widget messageWidget(String content, {String avaterurl= '',bool sender=false}) {
    Color setColor = sender ? Colors.green : Colors.white;

    Widget avater = Container(
      height: 40,
      width: 40,
      child: ClipRRect( //剪裁为圆角矩形
        borderRadius: BorderRadius.circular(10.0),
        child: sender ? Consumer<AuthModel>(
          builder: (context, user, child) {
            return Image.network(user.user.avater,fit: BoxFit.fill,);
          },
        ) : Image.network(avaterurl,fit: BoxFit.fill,)
      ),
    );
    Widget body = Container(
      width: 300,
      margin: sender ? EdgeInsets.only(right: 5) : EdgeInsets.only(left: 5),
        child: Align(alignment: sender ? Alignment.centerRight : Alignment.centerLeft,
        child:  Flex(direction: Axis.vertical,
          children: <Widget>[
            Card(
              elevation: 0.1,
              color: setColor,
              child: Padding(padding: EdgeInsets.only(left: 10,right: 10,bottom: 10,top: 10),
                  child: Column(
                    children: <Widget>[
                      Text(content,)
                    ],
                  )
              ),)
          ],
        ),)
    );
    Widget sendImg = Container(
      width: 1,
      margin: sender ? EdgeInsets.only(top: 5,right: 5) : EdgeInsets.only(bottom: 10,left: 5),
      child: sender ? Transform.rotate(
          angle: pi,child: CustomPaint(
        painter: ChatBoxPainter(
            color: setColor,
            width: 10,
            height: 10
        ),
      ),) : CustomPaint(
        painter: ChatBoxPainter(
          color: setColor,
          width: 10,
          height: 10
        ),
      ),
    );
    return Container(
      padding: EdgeInsets.only(left: 10,right: 10),
      child: sender ? Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          body,
          sendImg,
          avater
        ],
      ) :  Row(
        children: <Widget>[
          avater,
          sendImg,
          body
        ],
      ),
    );
  }
}
class ChatBoxPainter extends CustomPainter {
  ChatBoxPainter(
      {@required this.width, @required this.height, @required this.color});
  final double width;
  final double height;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path()
      ..moveTo(0, height / 2)
      ..lineTo(width, height)
      ..lineTo(width, 0)
      ..lineTo(0, height / 2);

    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color
      ..strokeWidth = 1;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(ChatBoxPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(ChatBoxPainter oldDelegate) => false;
}
