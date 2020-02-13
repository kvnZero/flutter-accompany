import 'dart:math';

import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {

  TextEditingController _textController = new TextEditingController();
  GlobalKey _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text(
          '对方名称', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
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
                children: <Widget>[
                  messageWidget("大家如啊啊啊说果啊啊啊啊啊啊啊啊啊啊么啊啊啊啊啊好",'https://i03piccdn.sogoucdn.com/c54eb831b18dcd70',sender: true),
                  messageWidget("大家如啊啊啊说果啊啊啊啊啊啊啊啊啊啊么啊啊啊啊啊好",'https://i03piccdn.sogoucdn.com/c54eb831b18dcd70',sender: true),
                  messageWidget("大家如啊啊啊说果啊啊啊啊啊啊啊啊啊啊么啊啊啊啊啊好",'https://i03piccdn.sogoucdn.com/c54eb831b18dcd70',sender: true),
                  messageWidget("大家如啊啊啊说果啊啊啊啊啊啊啊啊啊啊么啊啊啊啊啊好",'https://i03piccdn.sogoucdn.com/c54eb831b18dcd70',sender: true),
                  messageWidget("大家如啊啊啊说果啊啊啊啊啊啊啊啊啊啊么啊啊啊啊啊好",'https://i03piccdn.sogoucdn.com/c54eb831b18dcd70',sender: true),
                  messageWidget("大家如啊啊啊说果啊啊啊啊啊啊啊啊啊啊么啊啊啊啊啊好",'https://i03piccdn.sogoucdn.com/c54eb831b18dcd70',sender: true),
                  messageWidget("大家如啊啊啊说果啊啊啊啊啊啊啊啊啊啊么啊啊啊啊啊好",'https://i03piccdn.sogoucdn.com/c54eb831b18dcd70',sender: true),
                  messageWidget("大家如啊啊啊说果啊啊啊啊啊啊啊啊啊啊么啊啊啊啊啊好",'https://i03piccdn.sogoucdn.com/c54eb831b18dcd70',sender: true),
                  messageWidget("大家如啊啊啊说果啊啊啊啊啊啊啊啊啊啊么啊啊啊啊啊好",'https://i03piccdn.sogoucdn.com/c54eb831b18dcd70',sender: true),
                  messageWidget("大家如啊啊啊说果啊啊啊啊啊啊啊啊啊啊么啊啊啊啊啊好",'https://i03piccdn.sogoucdn.com/c54eb831b18dcd70',sender: true),
                  messageWidget("大家如啊啊啊说果啊啊啊啊啊啊啊啊啊啊么啊啊啊啊啊好",'https://i03piccdn.sogoucdn.com/c54eb831b18dcd70',sender: true),
                  messageWidget("大家如啊啊啊说果啊啊啊啊啊啊啊啊啊啊么啊啊啊啊啊好",'https://i03piccdn.sogoucdn.com/c54eb831b18dcd70',sender: true),
                  messageWidget("大家如啊啊啊说果啊啊啊啊啊啊啊啊啊啊么啊啊啊啊啊好",'https://i03piccdn.sogoucdn.com/c54eb831b18dcd70',sender: true),
                  messageWidget("大家如啊啊啊说果啊啊啊啊啊啊啊啊啊啊么啊啊啊啊啊好",'https://i03piccdn.sogoucdn.com/c54eb831b18dcd70'),
                ],
              padding: EdgeInsets.only(top: 5,bottom: 5),
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
                  IconButton(icon: Icon(Icons.send), onPressed: (){print("发送消息");}),
                ]
              )
            ),
          ))
        ],
      ),
    );
  }

  Widget messageWidget(String content, String avaterurl, {bool sender=false}) {
    Color setColor = sender ? Colors.green : Colors.white;

    Widget avater = Container(
      height: 40,
      width: 40,
      child: ClipRRect( //剪裁为圆角矩形
        borderRadius: BorderRadius.circular(10.0),
        child: Image.network(avaterurl,fit: BoxFit.fill,),
      ),
    );
    Widget body = Container(
      width: 300,
      margin: sender ? EdgeInsets.only(right: 5) : EdgeInsets.only(left: 5),
        child:Align(alignment: Alignment.centerLeft,
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
