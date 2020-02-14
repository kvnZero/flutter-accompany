import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:accompany/data/classes/message_show.dart';
import 'package:accompany/page/message/message_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:accompany/common/user_fun.dart';
class MsgWidget extends StatefulWidget {
  const MsgWidget({
    @required this.message,
  });

  final Map message;
  @override
  _MsgWidgetState createState() => _MsgWidgetState(message: message);
}

class _MsgWidgetState extends State<MsgWidget> {
   _MsgWidgetState({
    @required this.message,
  });
   Map message;
   Map user;
   bool done = false;
   MessageShow ml;
   int getid;
   @override
  void initState() {
    // TODO: implement initState
    ml = MessageShow.fromJson(message);
    getUserinfo();
    super.initState();
  }

  void getUserinfo() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String _saveUser = _prefs.getString('user_data');
    getid = ml.toid==json.decode(_saveUser)['id'] ? ml.fromid : ml.toid;
    Map _user = await UserFun?.userInfo(getid.toString());
    if(_user != null ){
      setState(() {
        user = _user;
        done=true;
      });
     }
  }

  @override
  Widget build(BuildContext context){

    return FlatButton(onPressed: (){
      ml.read=1;
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => MessagePage(toId: getid,user: user,)));}, child: Container(
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
              ml.read == 1 ? Container(
                height: 40,
                child: ClipRRect( //剪裁为圆角矩形
                  borderRadius: BorderRadius.circular(10.0),
                  child: done ? Image.network(user['avater'],fit: BoxFit.fill,) : Container() ,
                ),
              ) :
              Badge(
                position:BadgePosition(right: -5,top: -5),
                child:Container(
                  height: 40,
                  child: ClipRRect( //剪裁为圆角矩形
                    borderRadius: BorderRadius.circular(10.0),
                    child: done ? Image.network(user['avater'],fit: BoxFit.fill,) : Container(),
                  ),
                ),
              ),
              Container(
                height: 40,
                padding: EdgeInsets.only(left: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(width:  MediaQuery.of(context).size.width-120,
                          child: Row(
                            children: <Widget>[
                              Text(done ? user['nickname'].toString() : '', style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),)
                            ],
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Text(ml.time.substring(11),style: TextStyle(fontSize: 12,color: Colors.black26),)
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