import 'package:flutter/material.dart';
import 'package:accompany/data/models/auth.dart';
import 'package:provider/provider.dart';
import 'package:accompany/widget/myIconButton.dart';
import 'package:accompany/widget/goodsInfoWidget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeIndex extends StatefulWidget {
  @override
  _HomeIndexState createState() => _HomeIndexState();
}

class _HomeIndexState extends State<HomeIndex> with AutomaticKeepAliveClientMixin{

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

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
        elevation: 0.5,
      ),
      body:RefreshIndicator(
          child: ListView(
            children: <Widget>[
              typeGroup(),
              adBanner(),
              goodsList()
            ],
          ),
          onRefresh: (){}),
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

  Widget goodsList(){

    List goodsData = [
      {'image':'http://i0.hdslb.com/bfs/face/a9a41c8d0b5aa4fde8f9d4e401605189fbdfac23.jpg','title':'搜索生生世世生生世世是是是是是是是收到是都是大的爱上'},
      {'image':'https://i02piccdn.sogoucdn.com/de0a907176cce537','title':'搜索生生世世是是是是是是是收到是都是大的爱上搜索生生世世生生世世是是是是是是是收到是都是大的爱上生生世世是是是是是是是收到是都是大的爱上'},
      {'image':'https://i03piccdn.sogoucdn.com/2aaf9aa139ab1e88','title':'搜索生生世世生是都是大的爱上'},
      {'image':'https://i01piccdn.sogoucdn.com/f78fd10a2642fe7f','title':'搜索生生世世生生世世是是是是是是是收到是都搜索生生世世生生世世是是是是是是是收到是都是大的爱上搜索生生世世生生世世是是是是是是是收到是都是大的爱上是大的爱上'},
      {'image':'https://i01piccdn.sogoucdn.com/58afa2cc5c86eda1','title':'搜索生生世世生搜索生生世世生生世世是是是是是是是收到是都是大的爱上搜索生生世世生生世世是是是是是是是收到是都是大的爱上搜索生搜索生生世世生生世世是是是是是是是收到是都是大的爱上搜索生生世世生生世世是是是是是是是收到是都是大的爱上搜索生生世世生生世世是是是是是是是收到是都是大的爱上生世世生生世世是是是是是是是收到是都是大的爱上生世世是是是是是是是收到是都是大的爱上'},
      {'image':'https://i03piccdn.sogoucdn.com/bbc8883a8e45c9bf','title':'搜索生生世世生生世世是是是是是是搜索生生世世生生世世是是是是是是是收到是都是大的爱上搜索生生世世生生世世是是是是是是是收到是都是大搜索生生世世生生世世是是是是是是是收到是都是大的爱上的爱上是收到是都是大的爱上'},
      {'image':'https://i01piccdn.sogoucdn.com/5fb1802e5f17a292','title':'搜索生生世世生生世世是搜索生生世世生生世世是是是是是是是收到是都是大的爱上搜索生生世世生生世世是是是是是是是收到是都是大的爱上搜索生生世世生生世世是是是是是是是收到是都是大的爱上搜索生生世世生生世世是是是是是是是收到是都是大的爱上搜索生生世世生生世世是是是是是是是收到是都是大的爱上是是是是是是收到是都是大的爱上'},
    ];

    return Container(
      margin: EdgeInsets.only(top : 10,left: 5,right: 5),
//      padding: EdgeInsets.only(left: 5,right: 5),
      child: StaggeredGridView.countBuilder(
        primary: false,
        shrinkWrap: true,
        crossAxisCount: 2,
        itemCount: 5,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) => new GoodsInfo(imageUrl: goodsData[index]['image'], title: goodsData[index]['title'], price: 0, userName: ''),
        staggeredTileBuilder: (index) => new StaggeredTile.fit(1),
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
    );
//    'http://i0.hdslb.com/bfs/face/a9a41c8d0b5aa4fde8f9d4e401605189fbdfac23.jpg'
//    return GridView(
//      shrinkWrap: true,
//      physics: NeverScrollableScrollPhysics(),
//      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//      children: <Widget>[
//        GoodsInfo(),
//        GoodsInfo(),
//        GoodsInfo(),
//        GoodsInfo(),
//        GoodsInfo(),
//      ],
//    );
  }

}
