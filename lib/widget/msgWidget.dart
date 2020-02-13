import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:accompany/data/classes/message_list.dart';
import 'package:accompany/page/message/message_page.dart';
class MsgWidget extends StatelessWidget {
  const MsgWidget({
    @required this.message
  });

  final Map message;


  @override
  Widget build(BuildContext context) {
    MessageList ml = MessageList.fromJson(message);

    return FlatButton(onPressed: (){
      Navigator.push(context,
        MaterialPageRoute(builder: (context) => MessagePage()));}, child: Container(
      padding: EdgeInsets.all(10),
      decoration: new BoxDecoration(
        border: new Border(bottom: BorderSide(
            width: 0.3, color: Colors.black12, style: BorderStyle.solid)),
      ),
      child: Row(
        children: <Widget>[
          Row(
            children: <Widget>[
//              redB,
              ml.read == 0 ? Container(
                height: 40,
                child: ClipRRect( //剪裁为圆角矩形
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(ml.user.avater,fit: BoxFit.fill,),
                ),
              ) :
              Badge(
                position:BadgePosition(right: -5,top: -5),
                child:Container(
                  height: 40,
                  child: ClipRRect( //剪裁为圆角矩形
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(ml.user.avater,fit: BoxFit.fill,),
                  ),
                ),
              ),
              Container(
                height: 40,
                padding: EdgeInsets.only(left: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(width:  MediaQuery.of(context).size.width-120,
                          child: Row(
                            children: <Widget>[
                              Text(ml.user.nickname, style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),)
                            ],
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Text(ml.updateTime.substring(11),style: TextStyle(fontSize: 12,color: Colors.black26),)
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(width:  MediaQuery.of(context).size.width-70, child: Text(ml.content,overflow: TextOverflow.ellipsis,maxLines: 1,style: TextStyle(color: Colors.black54,fontSize: 14),),),
                      ],
                    )
                  ],
                ),)
            ],
          ),
        ],
      ),
    ),padding: EdgeInsets.zero,);
  }
}
