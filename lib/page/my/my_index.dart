import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:accompany/data/models/auth.dart';
import 'package:provider/provider.dart';class MyIndex extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyIndexState();
  }
}

class MyIndexState extends State<MyIndex> with SingleTickerProviderStateMixin{

  List<List<Map>> listButton = [
    [{'icon':Icons.enhanced_encryption,'color':Colors.black38, 'title':'商家中心','text':'','value':0},
      {'icon':Icons.content_paste,'color':Colors.black38, 'title':'订单管理','text':'','value':0},
      {'icon':Icons.card_giftcard,'color':Colors.black38, 'title':'邀请好友得好礼','text':'','value':0},
    ],
    [
      {'icon':Icons.bookmark,'color':Colors.black38, 'title':'我的帖子','text':'','value':0},
      {'icon':Icons.folder_open,'color':Colors.black38, 'title':'我的收藏','text':'','value':0},
    ],
    [
      {'icon':Icons.email,'color':Colors.black38, 'title':'意见反馈','text':'','value':0},
      {'icon':Icons.lightbulb_outline,'color':Colors.black38, 'title':'帮助中心','text':'','value':0},
    ],
    [
      {'icon':Icons.settings,'color':Colors.black38, 'title':'设置','text':'','value':0},
    ]
  ];

  Widget menuList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget userInfo(){
    Widget userinfo = Padding( padding: EdgeInsets.all(10),
      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Consumer<AuthModel>(
            builder: (context, user, child) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 60,
                    width: 60,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(user.user.avater,fit: BoxFit.fill,)
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 10),
                      child: Container(
                        width: 200,
                        child: Column(
                          children: <Widget>[
                            Container(
                              width:200,
                              child: Row(
                                children: <Widget>[
                                  Text(user.user.nickname, style: TextStyle(fontSize: 16),),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ))
                ],
              );
            },
          ),
          FlatButton(
            padding: EdgeInsets.zero,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('个人主页',style: TextStyle(fontSize: 14,color: Colors.black38),),
                Icon(Icons.chevron_right,size: 32,color: Colors.black26,),
              ],
            ),
            onPressed: (){print("跳转页面");},
          )
        ],
      ),
    );

    return Container(
      margin: EdgeInsets.only(top:10,bottom: 10),
      color: Colors.white,
      height:80,
      child: Column(
        children: <Widget>[
          userinfo,
        ],
      ),
    );
  }

  Widget createList(){
    List<Widget> body = [];
    for(int i=0; i<listButton.length;i++){
      List<Widget> _list = [];
      for(int j=0; j<listButton[i].length;j++){
        _list.add(NavButton(listButton[i][j]['icon'], listButton[i][j]['color'], listButton[i][j]['title'],text: listButton[i][j]['text'],value: listButton[i][j]['value']));
      }
      body.add(Container(
        color: Colors.white,
        margin: EdgeInsets.only(bottom: 5),
        child: Column(children: _list.map((e)=>e).toList(),),
      ));
    }
    return Container(child: Column(children: body.map((e)=>e).toList(),));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(appBar:AppBar(elevation: 0.5,title: Text('我',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),centerTitle: false,),
      body:RefreshIndicator(
          child: ListView(
            children: <Widget>[
              userInfo(),
              Container(child: createList(),),
              logoutButton()
//            createList(),
            ],
          ),
          onRefresh: (){}
      ),
    );
  }

  Widget pageCover(){
    return Container(
      height: 210,
      child: new Image.network("http://5b0988e595225.cdn.sohucs.com/images/20200103/0eddf8d53c1e4262aef9952f3c8bbfc3.jpeg", fit: BoxFit.fill,),
    );
  }

  Widget NavButton(IconData icon, Color iconColor, String title, {String text='', int value=0}){
    TextStyle redtextstyle = TextStyle(fontSize: 8,color: Colors.white);
    Widget redB = value>0 ? Stack(
      alignment: Alignment.center,
      children: <Widget>[
//        Text(value.toString(),style: TextStyle(fontSize: 8,color: Colors.white),),
        Badge(
          badgeContent: value>0 && value<100 ? Text(value.toString(),style: redtextstyle,) : Text('99+',style: redtextstyle,),
          child: Icon(icon,size: 28,color: iconColor),
        ),
      ],
    ) : Icon(icon,size: 28,color: iconColor);
    return FlatButton(onPressed: (){print("1");},
        padding: EdgeInsets.zero,
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: new BoxDecoration(
            border: new Border(bottom: BorderSide(width: 0.3,color: Colors.black12, style: BorderStyle.solid)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  redB,
                  Padding(padding: EdgeInsets.only(left: 10),child: Text(title, style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),)
                ],
              ),
              Row(
                children: <Widget>[
                  Text(text,style: TextStyle(fontSize: 14,color: Colors.black26),),
                  Icon(Icons.chevron_right,size: 32,color: Colors.black26,),
                ],
              )
            ],
          ),
        )
    );
  }

  Widget logoutButton(){
      return FlatButton(onPressed: (){
        showDialog(context: context,barrierDismissible: false,
        builder: (BuildContext context){
          return  Consumer<AuthModel>(
            builder: (context, user, child) {
              return AlertDialog(title: Center(child: Text("确定要退出账户",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w300),),),actions: <Widget>[
                FlatButton(onPressed: (){
                  print("确认退出");
                  user.logout();
                  Navigator.of(context).pop();
                }, child: Text("确定退出")),
                FlatButton(onPressed: (){
                  Navigator.of(context).pop();
                }, child: Text("取消退出",style: TextStyle(color: Colors.black38),)),
              ],);
            });
        });
      },
        padding: EdgeInsets.zero,
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: new BoxDecoration(
            border: new Border(bottom: BorderSide(width: 0.3,color: Colors.black12, style: BorderStyle.solid)),
            color: Colors.white
          ),
          child: Center(
            child:Text("退出账户",style: TextStyle(fontSize: 14,color: Colors.red[300]),),
          )
        )
      );
  }
}
