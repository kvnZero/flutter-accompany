import 'package:flutter/material.dart';
import 'package:accompany/data/models/auth.dart';
import 'package:provider/provider.dart';
import 'package:accompany/widget/myIconButton.dart';

class HomeIndex extends StatefulWidget {
  @override
  _HomeIndexState createState() => _HomeIndexState();
}

class _HomeIndexState extends State<HomeIndex>{

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: searchButton(),
        centerTitle: false,
        actions: <Widget>[
          collectionButton(),
        ],
      ),
      body: ListView(
        children: <Widget>[
          typeGroup(),
          adBanner(),
        ],
      )
    );
  }


  Widget collectionButton(){
    return Container(
      child: IconButton(
          padding: EdgeInsets.zero,
          alignment: Alignment.centerLeft,
          icon: Icon(Icons.favorite,color: Colors.red[800],), onPressed: (){
        print('跳转页面');}
      ),
    );
  }

  Widget searchButton(){
    return Container(
      child: Container(
          height: 40,
          child: FlatButton(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.black12,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(left: 0),child: Icon(Icons.search, size: 26,color: Colors.lightBlue,),),
                Padding(padding: EdgeInsets.only(left: 10),child: Text("标题名 / 商家名 / 地区",style: TextStyle(color: Colors.black26,fontSize: 14),)),
              ],
            ),
            onPressed: (){
              print('跳转页面');
            },
          )
      ),
    );
  }

  Widget typeGroup(){
    return Container(
      height: 160,
      decoration: new BoxDecoration(
          color: Colors.white  , // 底色
          borderRadius: new BorderRadius.circular((8.0)), // 圆角度
      ),
      margin: EdgeInsets.only(top : 10,left: 10,right: 10),
      child:GridView(
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5,childAspectRatio: 1.0),
        children: <Widget>[
          MyIconButton(icon: Icons.favorite, onPressed: (){}, title: '喜欢', titleStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
          MyIconButton(icon: Icons.favorite, onPressed: (){}, title: '喜欢', titleStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
          MyIconButton(icon: Icons.favorite, onPressed: (){}, title: '喜欢', titleStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
          MyIconButton(icon: Icons.favorite, onPressed: (){}, title: '喜欢', titleStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
          MyIconButton(icon: Icons.favorite, onPressed: (){}, title: '喜欢', titleStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
          MyIconButton(icon: Icons.favorite, onPressed: (){}, title: '喜欢', titleStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
        ],
      ),
    );
  }

  Widget adBanner(){
    return Container(
      height: 80,
      margin: EdgeInsets.only(top : 10,left: 10,right: 10),
      decoration: new BoxDecoration(
        color: Colors.white  , // 底色
        image:DecorationImage(image: NetworkImage('https://i04piccdn.sogoucdn.com/efa631166ff69f57'),fit: BoxFit.fill,),
        borderRadius: new BorderRadius.circular((8.0)), // 圆角度
      ),
    );
  }
}
